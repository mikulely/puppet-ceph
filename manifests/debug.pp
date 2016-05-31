class ceph::debug (
  $debug_enable = false,
) inherits ceph {

  $debug_options = [
    'debug_lockdep',
    'debug_context',
    'debug_crush',
    'debug_mds',
    'debug_mds_balancer',
    'debug_mds_locker',
    'debug_mds_log',
    'debug_mds_log_expire',
    'debug_mds_migrator',
    'debug_buffer',
    'debug_timer',
    'debug_filer',
    'debug_objecter',
    'debug_rados',
    'debug_rbd',
    'debug_journaler',
    'debug_objectcacher',
    'debug_client',
    'debug_osd',
    'debug_optracker',
    'debug_objclass',
    'debug_filestore',
    'debug_journal',
    'debug_ms',
    'debug_mon',
    'debug_monc',
    'debug_paxos',
    'debug_tp',
    'debug_auth',
    'debug_finisher',
    'debug_heartbeatmap',
    'debug_perfcounter',
    'debug_rgw',
    'debug_hadoop',
    'debug_asok',
    'debug_throttle',
  ]

  notify { "debug is $debug_enable": }

  $default_val = $debug_enable ? {
    'false' => '0/0',
    false   => '0/0',
    default => 'default',
  }

  $debug_options.each |$key| {
    $set_val = inline_template("<%= scope.lookupvar('ceph::$key') %>")
    $really_val = $set_val ? {
      undef   => $default_val,
      'undef' => $default_val,
      default => $set_val,
    }

    ceph_config {
      "global/${key}":   value => $really_val;
    }
  }
}
