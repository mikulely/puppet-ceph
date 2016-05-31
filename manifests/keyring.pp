define ceph::keyring (
  $secret = $ceph::params::common_key,
  $keyring_path = "/etc/ceph/ceph.${name}.keyring",
  $cap_mon = undef,
  $cap_osd = undef,
  $cap_mds = undef,
  $user = 'root',
  $group = 'root',
  $mode = '0644',
) {

  Exec {
    path    => $ceph::params::path,
  }

# to concat the capability settings
  if $cap_mon {
    $mon_caps = "--cap mon '${cap_mon}' "
  }
  if $cap_osd {
    $osd_caps = "--cap osd '${cap_osd}' "
  }
  if $cap_mds {
    $mds_caps = "--cap mds '${cap_mds}' "
  }

  $concat_caps = "${mon_caps}${osd_caps}${mds_caps}"


# generate the keyring file
  exec { "ceph-keyring-${name}":
    command => "ceph-authtool ${keyring_path} --create-keyring --name='${name}' --add-key='${secret}' ${concat_caps}",
    creates => $keyring_path,
    require => Class['ceph::package'],
  }

# set the correct mask for the keyring file
# TODO: make sure the user/group exists
  file { $keyring_path:
    ensure                  => file,
    owner                   => $user,
    group                   => $group,
    mode                    => $mode,
    selinux_ignore_defaults => true,
    require                 => Exec["ceph-keyring-${name}"]
  }
}
