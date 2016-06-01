define ceph::mon (
  $mon_addr = $::ipaddress,
  $key = $ceph::params::mon_key,
  $mon_host = $::hostname,
  $timeout = $ceph::params::timeout,
  ) {

  Exec {
    path    => $ceph::params::path,
  }

  $timeout_cmd = "timeout ${timeout}"

  # a puppet name translates into a ceph id, the meaning is different
  $id = $name
  $mon_data = "/var/lib/ceph/mon/ceph-${id}"

  #We need assign keyring_path for mon. key, because default keyring_path is not right for mon. key
  #It is very important.
  ceph::keyring { 'mon.':
    secret       => $key,
    keyring_path => '/etc/ceph/ceph.mon.keyring',
    cap_mon      => 'allow *',
  }

  ceph_config {
    "mon.${id}/host":                     value => $mon_host;
    "mon.${id}/mon_data":                     value => $mon_data;
    "mon.${id}/mon_addr":                     value => "${mon_addr}:6789";
  }

  file {$mon_data:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    selinux_ignore_defaults => true,
    require => Class['ceph'],
  }

  Ceph_Config["mon.${id}/host"] -> File[$mon_data]
  Ceph_Config["mon.${id}/mon_data"] -> File[$mon_data]
  Ceph_Config["mon.${id}/mon_addr"] -> File[$mon_data]

  exec {'ceph-mon-mkfs':
    command => "${timeout_cmd} ceph-mon --mkfs -i ${id} \
    --keyring /etc/ceph/ceph.mon.keyring \
    -c /etc/ceph/ceph.conf",
    creates => "${mon_data}/keyring",
    require => [
        File[$mon_data],
        Ceph::Keyring['mon.'],
    ]
  }

  file {"${mon_data}/sysvinit":
    ensure  => present,
    mode    => '0755',
    content => 'rongze',
    selinux_ignore_defaults => true,
    require => Exec['ceph-mon-mkfs'],
  }

  service {"ceph-mon.${id}":
    ensure  => running,
    start   => "service ceph start mon.${id}",
    stop    => "service ceph stop mon.${id}",
    status  => "service ceph status mon.${id}",
    require => [
        Exec['ceph-mon-mkfs'],
        File["${mon_data}/sysvinit"],
    ]
  }

  # Rsyslog configuration
  #::rsyslog::imfile { "ceph-mon-${id}":
  #  file_name        => "/var/log/ceph/ceph-mon.${id}.log",
  #  file_tag         => "ceph-mon-${id}",
  #  file_facility    => 'local3',
  #  polling_interval => 3,
  #}

  #::rsyslog::imfile { 'ceph-cluster':
  #  file_name        => '/var/log/ceph/ceph.log',
  #  file_tag         => 'ceph-cluster',
  #  file_facility    => 'local3',
  #  polling_interval => 3,
  #}
}
