define ceph::auth_key (
  $keyring_path = "/etc/ceph/ceph.${name}.keyring",
  $timeout = $ceph::params::timeout,
) {
  Exec {
    path    => $ceph::params::path,
  }

  Ceph::Mon<| |> -> Exec["ceph-inject-key-${name}"]
  $keyring_option = '--name mon. --keyring /etc/ceph/ceph.mon.keyring'

  $timeout_cmd = "timeout ${timeout}"

  exec { "ceph-inject-key-${name}":
    command => "${timeout_cmd} ceph ${keyring_option} auth add '${name}' --in-file ${keyring_path}",
    onlyif  => "${timeout_cmd} ceph ${keyring_option} -s",
    unless  => "${timeout_cmd} ceph ${keyring_option} auth list | grep -sqw '${name}'",
    require => [
      Class['ceph'],
      Package['ceph'],
      File[$keyring_path],
      Ceph::Keyring['mon.'],
    ]
  }
}
