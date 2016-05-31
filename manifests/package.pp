class ceph::package (
){

    package { 'ceph':
        ensure  => present,
    }

    package { 'xfsprogs':
        ensure => present,
    }

    file { '/var/lib/ceph/':
        ensure => directory,
        owner  => 'root',
        group  => 0,
        selinux_ignore_defaults => true,
        mode   => '0755',
    }

    file { '/var/run/ceph':
        ensure => directory,
        owner  => 'root',
        group  => 0,
        selinux_ignore_defaults => true,
        mode   => '0755',
    }

    file { '/var/lib/ceph/mon':
        ensure  => directory,
        owner   => 'root',
        group   => 0,
        mode    => '0755',
        selinux_ignore_defaults => true,
        require => File['/var/lib/ceph']
    }

    file { '/var/lib/ceph/osd':
        ensure  => directory,
        owner   => 'root',
        group   => 0,
        mode    => '0755',
        selinux_ignore_defaults => true,
        require => File['/var/lib/ceph']
    }

    file { '/var/lib/ceph/mds':
        ensure  => directory,
        owner   => 'root',
        group   => 0,
        mode    => '0755',
        selinux_ignore_defaults => true,
        require => File['/var/lib/ceph']
    }

    file { '/var/lib/ceph/tmp':
        ensure  => directory,
        owner   => 'root',
        group   => 0,
        mode    => '0755',
        selinux_ignore_defaults => true,
        require => File['/var/lib/ceph']
    }
}
