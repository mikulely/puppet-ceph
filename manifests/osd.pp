# $osd_mount_options  = 'rw,noatime,inode64,logbsize=256k,delaylog,noexec,nodev,nodiratime,barrier=0',
# $safeguard is used for protect journal device don't be zero

define ceph::osd (
  $osd_journal        = undef,
  $osd_journal_size   = $ceph::params::osd_journal_size,
  $osd_mount_options  = $ceph::params::osd_xfs_mount_options,
  $osd_mkfs_options   = $ceph::params::osd_xfs_mkfs_options,
  $timeout            = $ceph::params::timeout,
  $safeguard          = true,
  $block_scheduler    = "noop",
) {

  Exec {
    path    => $ceph::params::path,
  }

  $timeout_cmd = "timeout ${timeout}"

  if $name =~ /^wwn-/ {
    $disk_fact = "disk_label_${name}"
    $osd_dev = inline_template('<%= scope.lookupvar(@disk_fact) or \
    "undefined" %>')
    if $osd_dev == "undefined" {
      fail("there is not ${disk_fact} facter")
    }

    $mount_dev = "/dev/disk/by-id/${name}"

  } elsif $name =~ /^sd/ {
    $osd_dev = "/dev/${name}"
    $mount_dev = $osd_dev

  } elsif $name =~ /^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/ {
    $disk_fact = "disk_label_${name}"
    $osd_dev = inline_template('<%= scope.lookupvar(@disk_fact) or \
    "undefined" %>')
    if $osd_dev == "undefined" {
      fail("there is not ${disk_fact} facter")
    }

    $mount_dev = "/dev/disk/by-uuid/${name}"

  } else {
    $osd_dev = $name
    $mount_dev = $osd_dev

  }

  if $osd_journal and $osd_journal =~ /^wwn-/ {
    $journal_disk_fact = "disk_label_${osd_journal}"
    $osd_journal_device = inline_template('<%= scope.lookupvar(@journal_disk_fact) or \
    "undefined" %>')
    if $osd_journal_device == "undefined" {
      fail("there is not ${journal_disk_fact} facter")
    }

    $osd_journal_path = "/dev/disk/by-id/${osd_journal}"

  } elsif $osd_journal and $osd_journal =~ /^sd/ {
    $osd_journal_path = "/dev/${osd_journal}"
  } else {
    $osd_journal_path = $osd_journal
  }

  $keyring_option = '--name client.admin --keyring /etc/ceph/ceph.client.admin.keyring'
  Ceph::Mon<| |> -> Exec["mkfs_${osd_dev}"]
  Ceph::Auth_key<| |> -> Exec["mkfs_${osd_dev}"]

  exec { "mkfs_${osd_dev}":
    command => "mkfs.xfs ${osd_mkfs_options} ${osd_dev}",
    unless  => "xfs_admin -l ${osd_dev}",
    onlyif  => "ls ${osd_dev}",
    require => Class['ceph'],
  }


  $blkid_uuid_fact = "blkid_uuid_${osd_dev}"
  # $osd_uuid is usded for Exec["ceph-osd-mkfs-${osd_id}"]
  $osd_uuid = inline_template('<%= scope.lookupvar(@blkid_uuid_fact) or \
  "undefined" %>')
  $osd_id_fact = "ceph_osd_id_${osd_dev}"
  $osd_id = inline_template('<%= scope.lookupvar(@osd_id_fact) or \
  "undefined" %>')

  if $osd_id == "undefined" {

    exec { "ceph_osd_create_id_${osd_dev}":
      command => "/bin/true  # comment to satisfy puppet syntax requirements
      set -ex
      osd_uuid=\$(/sbin/blkid -s UUID -o value ${osd_dev})
      ${timeout_cmd} ceph ${keyring_option} osd create --concise \$osd_uuid",
      require => [
        Ceph::Keyring['client.admin'],
        Exec["mkfs_${osd_dev}"],
      ]
    }
  } else {
    $osd_data = "/var/lib/ceph/osd/ceph-${osd_id}"

    ceph_config {
      "osd.${osd_id}/host":                     value => $::hostname;
      "osd.${osd_id}/osd_data":                 value => $osd_data;
      "osd.${osd_id}/osd_journal":              value => $osd_journal_path;
      "osd.${osd_id}/osd_journal_size":         value => $osd_journal_size;
      "osd.${osd_id}/umcloud_osd_device":        value => $osd_dev;
      "osd.${osd_id}/umcloud_osd_mount_device":  value => $mount_dev;
      "osd.${osd_id}/umcloud_osd_name":          value => $name;
      "osd.${osd_id}/umcloud_osd_journal_name":  value => $osd_journal;
      "osd.${osd_id}/umcloud_osd_uuid":          value => $osd_uuid;
    }

    file { $osd_data:
      ensure => directory,
      selinux_ignore_defaults => true,
    }

    Ceph_Config["osd.${osd_id}/host"] -> File[$osd_data]
    Ceph_Config["osd.${osd_id}/osd_data"] -> File[$osd_data]
    Ceph_Config["osd.${osd_id}/osd_journal"] -> File[$osd_data]
    Ceph_Config["osd.${osd_id}/osd_journal_size"] -> File[$osd_data]

    $simple_label = regsubst($osd_dev, '^\/dev\/([a-z]+)\d{0,2}$', '\1')
    if $simple_label != "" {
      exec {"${simple_label}_block_scheduler":
        path    => "/bin",
        user    => "root",
        command => "echo $block_scheduler > /sys/block/${simple_label}/queue/scheduler",
      }
    }
    mount { $osd_data:
      ensure  => mounted,
      device  => $mount_dev,
      fstype  => 'xfs',
      options => $osd_mount_options,
      pass    => 2,
      require => [
        Exec["mkfs_${osd_dev}"],
        File[$osd_data],
      ],
    }

    if ($safeguard == false or $safeguard == 'false') and $osd_journal_path {
      exec { "ceph-osd-clear-journal-${osd_id}":
        command => "dd if=/dev/zero of=${osd_journal_path} bs=1M count=10 oflag=direct",
        before  => Exec["ceph-osd-mkfs-${osd_id}"],
        unless => "ls ${osd_data}/keyring",
        require => Mount[$osd_data],
      }
    }

    exec { "ceph-osd-mkfs-${osd_id}":
      command => "ceph-osd -c /etc/ceph/ceph.conf --mkfs --mkjournal \
      --mkkey -i ${osd_id} --osd-uuid ${osd_uuid}",
      creates => "${osd_data}/keyring",
      require => [
        Mount[$osd_data],
      ]
    }

    exec { "ceph-osd-register-${osd_id}":
      command => "${timeout_cmd} ceph ${keyring_option} \
      auth add osd.${osd_id} osd 'allow *' mon 'allow rwx' \
      -i ${osd_data}/keyring",
      unless  => "/bin/ls ${osd_data}/sysvinit",
      require => [
        Exec["ceph-osd-mkfs-${osd_id}"],
        Ceph::Keyring['client.admin'],
      ]
    }

    file { "${osd_data}/sysvinit":
      ensure  => present,
      mode    => '0755',
      content => 'Rongze',
      selinux_ignore_defaults => true,
      require => Exec["ceph-osd-register-${osd_id}"],
    }

    service { "ceph-osd.${osd_id}":
      ensure  => running,
      start   => "/sbin/service ceph start osd.${osd_id}",
      stop    => "/sbin/service ceph stop osd.${osd_id}",
      status  => "/sbin/service ceph status osd.${osd_id}",
      require => File["${osd_data}/sysvinit"],
    }

    # Rsyslog configuration
    ::rsyslog::imfile { "ceph-osd-${osd_id}":
      file_name        => "/var/log/ceph/ceph-osd.${osd_id}.log",
      file_tag         => "ceph-osd-${osd_id}",
      file_facility    => 'local3',
      polling_interval => 3,
    }
  }
}
