class ceph (
  $release                      = $ceph::params::relase,
  $ceph_yum_repo_enable         = $ceph::params::ceph_yum_repo_enable,
  $osd_disk_type                = 'ssd',

  $fsid                         = $ceph::params::fsid,
  $perf                         = $ceph::params::perf,
  $mutex_perf_counter           = $ceph::params::mutex_perf_counter,
  $syslog_enable                = $ceph::params::syslog_enable,
  $mon_initial_members          = undef,
  $mon_host                     = undef,
  $cluster_network              = undef,
  $public_network               = undef,

  $auth_enable                  = $ceph::params::auth_enable,
  $admin_key                    = $ceph::params::admin_key,
  $radosgw_key                    = $ceph::params::radosgw_key,

  $mon_osd_full_ratio           = $ceph::params::mon_osd_full_ratio,
  $mon_osd_nearfull_ratio       = $ceph::params::mon_osd_nearfull_ratio,

  $rbd_cache                           = $ceph::params::rbd_cache,
  $rbd_cache_size                      = $ceph::params::rbd_cache_size,
  $rbd_cache_max_dirty                 = $ceph::params::rbd_cache_max_dirty,
  $rbd_cache_target_dirty              = $ceph::params::rbd_cache_target_dirty,
  $rbd_cache_max_dirty_age             = $ceph::params::rbd_cache_max_dirty_age,
  $rbd_cache_writethrough_until_flush  = $ceph::params::rbd_cache_writethrough_until_flush,

  $osd_heartbeat_interval       = $ceph::params::osd_heartbeat_interval,
  $osd_heartbeat_grace          = $ceph::params::osd_heartbeat_grace,
  $osd_heartbeat_min_peers      = $ceph::params::osd_heartbeat_min_peers,
  $osd_mon_heartbeat_interval   = $ceph::params::osd_mon_heartbeat_interval,
  $osd_heartbeat_addr           = undef,

  $osd_pool_default_pg_num      = $ceph::params::osd_pool_default_pg_num,
  $osd_pool_default_pgp_num     = $ceph::params::osd_pool_default_pgp_num,
  $osd_pool_default_size        = $ceph::params::osd_pool_default_size,
  $osd_pool_default_min_size    = $ceph::params::osd_pool_default_min_size,
  $osd_pool_default_crush_rule  = $ceph::params::osd_pool_default_crush_rule,
  $osd_crush_chooseleaf_type    = $ceph::params::osd_crush_chooseleaf_type,

  ## osd performance options begin
  ## these options will be used by ceph::osd_perf

  $osd_op_threads               = undef,
  $osd_op_thread_timeout        = undef,
  $osd_op_complaint_time        = undef,

  $osd_leveldb_write_buffer_size= undef,
  $osd_leveldb_cache_size       = undef,
  $osd_leveldb_block_size       = undef,
  $osd_leveldb_bloom_size       = undef,
  $osd_leveldb_max_open_files   = undef,
  $osd_leveldb_compression      = undef,
  $osd_leveldb_paranoid         = undef,

  $osd_journal_size             = undef,
  $journal_queue_max_ops        = undef,
  $journal_queue_max_bytes      = undef,
  $journal_max_write_bytes      = undef,
  $journal_max_write_entries    = undef,

  $filestore_op_threads              = undef,
  $filestore_queue_max_ops           = undef,
  $filestore_queue_max_bytes         = undef,
  $filestore_queue_committing_max_ops= undef,
  $filestore_max_inline_xattr_size   = undef,
  $filestore_max_inline_xattrs       = undef,
  $filestore_xattr_use_omap          = undef,
  $filestore_fd_cache_random         = undef,
  $filestore_max_sync_interval       = undef,
  $filestore_min_sync_interval       = undef,
  $filestore_omap_header_cache_size  = undef,
  $filestore_fiemap                  = undef,

  $osd_client_message_cap            = undef,
  $osd_client_message_size_cap       = undef,
  $ms_dispatch_throttle_bytes        = undef,

  $filestore_wbthrottle_xfs_ios_hard_limit        = undef,
  $filestore_wbthrottle_xfs_bytes_hard_limit      = undef,
  $filestore_wbthrottle_xfs_inodes_hard_limit     = undef,
  $filestore_wbthrottle_xfs_ios_start_flusher     = undef,
  $filestore_wbthrottle_xfs_bytes_start_flusher   = undef,
  $filestore_wbthrottle_xfs_inodes_start_flusher  = undef,
  $filestore_wbthrottle_enable                    = undef,

  $osd_recovery_threads          = undef,
  $osd_recovery_thread_timeout   = undef,
  $osd_recovery_max_active       = undef,
  $osd_recovery_max_single_start = undef,
  $osd_recovery_max_chunk        = undef,
  $osd_recovery_op_priority      = undef,
  $osd_client_op_priority        = undef,

  $osd_scrub_thread_timeout          = undef,
  $osd_scrub_finalize_thread_timeout = undef,
  $osd_max_scrubs                    = undef,
  $osd_scrub_load_threshold          = undef,
  $osd_scrub_min_interval            = undef,
  $osd_scrub_max_interval            = undef,
  $osd_scrub_chunk_min               = undef,
  $osd_scrub_chunk_max               = undef,
  $osd_deep_scrub_interval           = undef,
  $osd_deep_scrub_stride             = undef,

  ## osd performance options end

  ## debug setting begin

  $debug_enable          = $ceph::params::debug_enable,

  $debug_lockdep         = undef,
  $debug_context         = undef,
  $debug_crush           = undef,
  $debug_mds             = undef,
  $debug_mds_balancer    = undef,
  $debug_mds_locker      = undef,
  $debug_mds_log         = undef,
  $debug_mds_log_expire  = undef,
  $debug_mds_migrator    = undef,
  $debug_buffer          = undef,
  $debug_timer           = undef,
  $debug_filer           = undef,
  $debug_objecter        = undef,
  $debug_rados           = undef,
  $debug_rbd             = undef,
  $debug_journaler       = undef,
  $debug_objectcacher    = undef,
  $debug_client          = undef,
  $debug_osd             = undef,
  $debug_optracker       = undef,
  $debug_objclass        = undef,
  $debug_filestore       = undef,
  $debug_journal         = undef,
  $debug_ms              = undef,
  $debug_mon             = undef,
  $debug_monc            = undef,
  $debug_paxos           = undef,
  $debug_tp              = undef,
  $debug_auth            = undef,
  $debug_finisher        = undef,
  $debug_heartbeatmap    = undef,
  $debug_perfcounter     = undef,
  $debug_rgw             = undef,
  $debug_hadoop          = undef,
  $debug_asok            = undef,
  $debug_throttle        = undef,

  ## debug setting end

  $filestore_fd_cache_size           = $ceph::params::filestore_fd_cache_size,
  $osd_crush_update_on_start         = $ceph::params::osd_crush_update_on_start,

  $mon_osd_adjust_heartbeat_grace    = $ceph::params::mon_osd_adjust_heartbeat_grace,
  $mon_osd_adjust_down_out_interval  = $ceph::params::mon_osd_adjust_down_out_interval,
  $mon_osd_down_out_interval         = $ceph::params::mon_osd_down_out_interval,
) inherits ceph::params {

  # Make sure ceph is installed before managing the configuration

  # ==========================================================================
  # ==========================================================================
  # install ceph
  class { 'ceph::repo':
    release              => $release,
    ceph_yum_repo_enable => $ceph_yum_repo_enable,
  }
  class { 'ceph::package': }
  Class['ceph::repo'] -> Class['ceph::package'] -> Ceph_Config<| |>

  ceph::keyring { 'client.admin':
    secret       => $admin_key,
    cap_mon      => 'allow *',
    cap_osd      => 'allow *',
  }

  ceph::keyring { 'client.radosgw':
    secret       => $radosgw_key,
    cap_mon      => 'allow rx',
    cap_osd      => 'allow *',
  }

  # ==========================================================================
  # ==========================================================================
  # cluster config

  ceph_config {
    'global/fsid':                        value => $fsid;
  }

  # monitors
  if $mon_initial_members {
    ceph_config {
      'global/mon_initial_members':  value => $mon_initial_members
    }
  } else {
    ceph_config {
      'global/mon_initial_members': ensure => absent,
    }
  }

  if $mon_host {
    ceph_config {
      'global/mon_host':             value => $mon_host
    }
  } else {
    ceph_config {
      'global/mon_host':            ensure => absent,
    }
  }

  # network config
  if $cluster_network {
    ceph_config {
      'global/cluster_network':      value => $cluster_network
    }
  } else {
    ceph_config {
      'global/cluster_network':     ensure => absent,
    }
  }

  if $public_network {
    ceph_config {
      'global/public_network':       value => $public_network
    }
  } else {
    ceph_config {
      'global/public_network':      ensure => absent,
    }
  }

  # debug settting
  class { 'ceph::debug':
    debug_enable => $debug_enable,
  }

  # perf counter
  ceph_config {
    'global/perf':  value                 => $perf;
    'global/mutex_perf_counter':  value   => $mutex_perf_counter;
  }

  # syslog
  if $syslog_enable == true or $syslog_enable == 'true' {
    ceph_config {
      'global/log_file':               value => 'none';
      'global/log_to_syslog':          value => true;
      'global/err_to_syslog':          value => true;
      'mon/mon_cluster_log_to_syslog': value => true;
      'mon/mon_cluster_log_file':      value => 'none';
    }
  } else {
    ceph_config {
      'global/log_file':               value => '/var/log/ceph/$cluster-$name.log';
      'global/log_to_syslog':          value => false;
      'global/err_to_syslog':          value => false;
      'mon/mon_cluster_log_to_syslog': value => false;
      'mon/mon_cluster_log_file':      value => '/var/log/ceph/$cluster.log';
    }
  }

  # ==========================================================================
  # ==========================================================================
  # auth config
  if $auth_enable == 'true' or $auth_enable == true {
    $auth_type = 'cephx'
  } else {
    $auth_type = 'none'
  }
  ceph_config {
    'global/auth_cluster_required': value => $auth_type;
    'global/auth_service_required': value => $auth_type;
    'global/auth_client_required':  value => $auth_type;
    'global/auth_supported':        value => $auth_type;
  }

  # ==========================================================================
  # ==========================================================================
  # ratio
  ceph_config {
    'global/mon_osd_full_ratio':          value => $mon_osd_full_ratio;
    'global/mon_osd_nearfull_ratio':      value => $mon_osd_nearfull_ratio;
  }

  # ==========================================================================
  # ==========================================================================
  # rbd
  ceph_config {
    'client/rbd_cache':                                value => $rbd_cache;
    'client/rbd_cache_size':                           value => $rbd_cache_size;
    'client/rbd_cache_max_dirty':                      value => $rbd_cache_max_dirty;
    'client/rbd_cache_target_dirty':                   value => $rbd_cache_target_dirty;
    'client/rbd_cache_max_dirty_age':                  value => $rbd_cache_max_dirty_age;
    'client/rbd_cache_writethrough_until_flush':       value => $rbd_cache_writethrough_until_flush;
    'client/admin_socket':                             value => '/var/run/ceph/rbd-$pid.asok';
  }

  # ==========================================================================
  # ==========================================================================
  # osd pool
  case $osd_pool_default_crush_rule {
    'data': {
      $crush_rule = 0
    }
    'metadata': {
      $crush_rule = 1
    }
    'rbd': {
      $crush_rule = 2
    }
    default: {
      fail("osd_pool_default_crush_rule = ${osd_pool_default_crush_rule} is not supported")
    }
  }

  case $osd_crush_chooseleaf_type {
    'osd': {
      $leaf_type = 0
    }
    'host': {
      $leaf_type = 1
    }
    'rack': {
      $leaf_tpool_default_pg_numype = 2
    }
    'row': {
      $leaf_type = 3
    }
    'room': {
      $leaf_type = 4
    }
    'datacenter': {
      $leaf_type = 5
    }
    'root': {
      $leaf_type = 6
    }
    default: {
      fail("osd_crush_chooseleaf_type = ${osd_crush_chooseleaf_type} is not supported")
    }
  }

  ceph_config {
    'global/osd_pool_default_crush_rule': value => $crush_rule;
    'global/osd_crush_chooseleaf_type':   value => $leaf_type;
  }

  ceph_config {
    'global/osd_pool_default_pg_num':     value => $osd_pool_default_pg_num;
    'global/osd_pool_default_pgp_num':    value => $osd_pool_default_pgp_num;
    'global/osd_pool_default_size':       value => $osd_pool_default_size;
    'global/osd_pool_default_min_size':   value => $osd_pool_default_min_size;
  }

  # ==========================================================================
  # ==========================================================================
  # osd config

  # osd heartbeat
  ceph_config {
    'osd/osd_heartbeat_interval':     value => $osd_heartbeat_interval;
    'osd/osd_heartbeat_grace':        value => $osd_heartbeat_grace;
    'osd/osd_heartbeat_min_peers':    value => $osd_heartbeat_min_peers;
    'osd/osd_mon_heartbeat_interval': value => $osd_mon_heartbeat_interval;
  }

  if $osd_heartbeat_addr {
    ceph_config {
      'osd/osd_heartbeat_addr':         value => $osd_heartbeat_addr;
    }
  } else {
    ceph_config {
      'osd/osd_heartbeat_addr':     ensure => absent,
    }
  }

  # osd performance options
  ceph_config {
    'osd/umcloud_osd_disk_type':   value => $osd_disk_type;
  }

  class { 'ceph::osd_perf':
    disk_type => $osd_disk_type,
  }

  # osd start option
  ceph_config {
    'osd/osd_crush_update_on_start':         value => $osd_crush_update_on_start;
  }

  # mon osd interaction
  ceph_config {
    'mon/mon_osd_adjust_heartbeat_grace':    value => $mon_osd_adjust_heartbeat_grace;
    'mon/mon_osd_adjust_down_out_interval':  value => $mon_osd_adjust_down_out_interval;
    'mon/mon_osd_down_out_interval':         value => $mon_osd_down_out_interval;
  }

  # ==========================================================================
  # ==========================================================================
  # others

  # set max_open_files and filestore_fd_cache_size
  # max_open_files = filestore_fd_cache_size + 10000 will be safe,
  # ceph-osd will not open too many files
  $max_open_files = $filestore_fd_cache_size + 10000
  ceph_config {
    'osd/max_open_files': value => $max_open_files;
  }

}
