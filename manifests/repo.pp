class ceph::repo (
  $release = 'dumpling',
  $ceph_yum_repo_enable = true,
) {

  if $ceph_yum_repo_enable {
    $enabled = 1
  } else {
    $enabled = 0
  }
  yumrepo { 'ext-epel-6.8':
    descr       => 'External EPEL 6.8',
    name        => 'ext-epel-6.8',
    baseurl     => absent,
    gpgcheck    => '0',
    gpgkey      => absent,
    enabled      => $enabled,
    #mirrorlist => "https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=\${basearch}",
    # This is needed to avoid warning (using double-quotes) in puppet-lint
    # Can be removed when https://github.com/rodjek/puppet-lint/pull/234 is merged
    mirrorlist => join(['https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$', 'basearch'], '')
  }

  yumrepo { 'ext-ceph':
    descr      => "External Ceph ${release}",
    name       => "ext-ceph-${release}",
    baseurl    => "http://ceph.com/rpm-${release}/el6/\$basearch",
    gpgcheck   => '1',
    gpgkey     => 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc',
    enabled      => $enabled,
    mirrorlist => absent,
  }

  yumrepo { 'ext-ceph-noarch':
    descr      => 'External Ceph noarch',
    name       => "ext-ceph-${release}-noarch",
    baseurl    => "http://ceph.com/rpm-${release}/el6/noarch",
    gpgcheck   => '1',
    gpgkey     => 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc',
    enabled      => $enabled,
    mirrorlist => absent,
  }

}
