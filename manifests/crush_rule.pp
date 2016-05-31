# $leaf in {'osd', 'host', 'rack', 'row', 'room', 'datacenter', 'root'}

define ceph::crush_rule (
  $root         = 'default',
  $leaf         = 'host',
  $timeout = $ceph::params::timeout,
) {
  Exec {
    path    => $ceph::params::path,
  }

  Ceph::Mon<| |> -> Exec["create-ceph-crush-rule-${name}"]
  $keyring_option = '--name mon. --keyring /etc/ceph/ceph.mon.keyring'

  $timeout_cmd = "timeout ${timeout}"

  exec { "create-ceph-crush-rule-${name}":
    command => "${timeout_cmd} ceph ${keyring_option} osd crush rule create-simple ${name} ${root} ${leaf}",
    unless  => "${timeout_cmd} ceph ${keyring_option} osd crush rule list | grep -sqw '${name}'",
    require => [
      Class['ceph'],
      Ceph::Keyring['mon.'],
    ]
  }
}
