# how to calculate the optimal pg_num, pg_num = 512 * osd_num / rep_size .
# 512 is the best pgs in one OSD.

define ceph::pool (
  $ensure       = true,
  $pg_num       = 1024,
  $pgp_num      = 1024,
  $rep_size     = 2,
  $timeout = $ceph::params::timeout,
) {

  Exec {
    path    => $ceph::params::path,
  }

  $timeout_cmd = "timeout ${timeout}"
  $pool = $name
  $keyring_option = '--name mon. --keyring /etc/ceph/ceph.mon.keyring'

  if $ensure {
    Ceph::Mon<| |> -> Exec["create-pool-${pool}"]

    exec { "create-pool-${pool}":
      unless  => "${timeout_cmd} ceph ${keyring_option} osd pool get ${pool} size",
      command => "${timeout_cmd} ceph ${keyring_option} osd pool create ${pool} ${pg_num}",
      require => [
        Class['ceph'],
        Ceph::Keyring['mon.'],
      ]
    }

    exec { "set-pool-rep-size-${pool}":
      command => "${timeout_cmd} ceph ${keyring_option} osd pool set ${pool} size ${rep_size}",
      onlyif  => "${timeout_cmd} sh -c \"[[ ${rep_size} != `ceph ${keyring_option} osd pool get ${pool} size `]]\"",
      require => Exec["create-pool-${pool}"],
    }

    exec { "set-pool-pg-num-${pool}":
      command => "${timeout_cmd} ceph ${keyring_option} osd pool set ${pool} pg_num ${pg_num}",
      onlyif  => "${timeout_cmd} sh -c \"[[ ${pg_num} != `ceph ${keyring_option} osd pool get ${pool} pg_num`]]\"",
      require => Exec["set-pool-rep-size-${pool}"],
    }

    exec { "set-pool-pgp-num-${pool}":
      command => "${timeout_cmd} ceph ${keyring_option} osd pool set ${pool} pgp_num ${pgp_num}",
      onlyif  => "${timeout_cmd} sh -c \"[[ ${pgp_num} != `ceph ${keyring_option} osd pool get ${pool} pgp_num`]]\"",
      require => Exec["set-pool-rep-size-${pool}"],
    }
  } else {
    Ceph::Mon<| |> -> Exec["delete-pool-${pool}"]

    exec { "delete-pool-${pool}":
      onlyif  => "${timeout_cmd} ceph ${keyring_option} osd pool get ${pool} size",
      command => "${timeout_cmd} ceph ${keyring_option} osd pool delete ${pool} ${pool} --yes-i-really-really-mean-it",
      require => [
        Ceph::Keyring['mon.'],
      ]
    }
  }


}
