# the codes is copy from openstack puppet-ceph module,
# I modified it

define ceph::rgw (
  $key = $ceph::params::radosgw_key,
  $user = "root",
  $rgw_data = "/var/lib/ceph/radosgw/ceph-${name}",
  $rgw_log_file = '/var/log/ceph/radosgw.log',
  $rgw_dns_name = "s3.invalidity.com",
  $rgw_socket_path = "/var/run/ceph/ceph.radosgw.${name}.sock",
  $rgw_s3_auth_use_keystone = true,
  $rgw_keystone_url = "http://you-need-fill-correct-url:35357/v2",
  $rgw_keystone_admin_token = "invalidity_token",
  $rgw_keystone_accepted_roles = $ceph::params::rgw_keystone_accepted_roles,
) {

  Exec {
    path    => $ceph::params::path,
  }

  # we will generate the keyring
  # the monitor will enable the keyring
  $keyring_path = "/etc/ceph/ceph.client.radosgw.keyring"

  ceph_config {
    "client.radosgw/host": value => $::hostname;
    "client.radosgw/user": value => $user;
    "client.radosgw/keyring": value => $keyring_path;
    "client.radosgw/log_file": value => $rgw_log_file;
    "client.radosgw/rgw_dns_name": value => $rgw_dns_name;
    "client.radosgw/rgw_socket_path": value => $rgw_socket_path;
    "client.radosgw/rgw_s3_auth_use_keystone": value => $rgw_s3_auth_use_keystone;
    "client.radosgw/rgw_keystone_url": value => $rgw_keystone_url;
    "client.radosgw/rgw_keystone_admin_token": value => $rgw_keystone_admin_token;
    "client.radosgw/rgw_keystone_accepted_roles": value => $rgw_keystone_accepted_roles;
  }

  package { 'ceph-radosgw':
    ensure  => present,
  }

  file { '/var/lib/ceph/radosgw': # may be missing in RPM pkg
    ensure                  => directory,
    owner                   => 'root',
    group                   => 'root',
    selinux_ignore_defaults => true,
    mode                    => '0755',
  }

  file { $rgw_data:
    ensure                  => directory,
    owner                   => 'root',
    group                   => 'root',
    mode                    => '0755',
    selinux_ignore_defaults => true,
  }

  file { $rgw_log_file:
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  service { "radosgw-${name}":
    ensure => running,
    start => "/sbin/service ceph-radosgw start",
    stop => "/sbin/service ceph-radosgw stop",
    status => "/sbin/service ceph-radosgw status",
  }

  Package['ceph-radosgw']
  -> Ceph_Config<| |>
  -> File['/var/lib/ceph/radosgw']
  -> File[$rgw_data]
  -> File[$rgw_log_file]
  -> Service["radosgw-${name}"]

}
