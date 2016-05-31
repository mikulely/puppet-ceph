# $packaget_present in present or absent

class ceph::clear(
  $package_present = present,
) {

  Exec {
    path    => $ceph::params::path,
  }

  exec { 'clear_ceph':
    command => "/bin/true  # comment to satisfy puppet syntax requirements
    set -ex
    service ceph -a stop
    rm /etc/ceph/* -rf
    for dir in `ls /var/lib/ceph/osd/`
    do
      rm /var/lib/ceph/osd/\$dir/* -rf
      umount /var/lib/ceph/osd/\$dir
    done
    rm /var/lib/ceph/mon/* -rf
    rm /var/lib/ceph/osd/* -rf",
  }

  package { 'ceph':
    ensure => $package_present,
    require => Exec['clear_ceph'],
  }
}
