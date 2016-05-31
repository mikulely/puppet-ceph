class ceph::osd_perf::ssd inherits ceph::osd_perf::base {
  $perf_options = {
    # osd op,
    osd_op_threads               => 3,
    osd_op_thread_timeout        => 60,
    osd_op_complaint_time        => 1,

    # osd leveldb,
    osd_leveldb_write_buffer_size=> 33554432,
    osd_leveldb_cache_size       => 536870912, #OPT_U64
    osd_leveldb_block_size       => 131072,
    osd_leveldb_bloom_size       => 0,
    osd_leveldb_max_open_files   => 0,
    osd_leveldb_compression      => false,
    osd_leveldb_paranoid         => false,

    # osd journal,
    osd_journal_size             => 1024,
    journal_queue_max_ops        => 500000,       #OPT_INT
    journal_queue_max_bytes      => 1073741824,   #OPT_INT
    journal_max_write_bytes      => 1073741824,
    journal_max_write_entries    => 500000,

    # osd filestore,
    filestore_op_threads              => 4,
    filestore_queue_max_ops           => 5000,       #OPT_INT
    filestore_queue_max_bytes         => 1073741824, #OPT_INT
    filestore_queue_committing_max_ops=> 500000,
    filestore_max_inline_xattr_size   => 'default',
    filestore_max_inline_xattrs       => 6,
    filestore_xattr_use_omap          => 'default',
    filestore_fd_cache_size           => 204800, # we need more fd cache size
    filestore_fd_cache_random         => true,   # we custom params in ceph
    filestore_max_sync_interval       => 5,
    filestore_min_sync_interval       => 0.01,
    filestore_omap_header_cache_size  => 204800,
    filestore_fiemap                  => true,

    # osd message,
    osd_client_message_cap            => 500000,       #OPT_U64
    osd_client_message_size_cap       => 1073741824,   #OPT_U64
    ms_dispatch_throttle_bytes        => 1073741824,

    # osd filestore wbthrottle,
    filestore_wbthrottle_xfs_ios_hard_limit        => 500000,      #OPT_U64
    filestore_wbthrottle_xfs_bytes_hard_limit      => 10737418240, #OPT_U64
    filestore_wbthrottle_xfs_inodes_hard_limit     => 50000,
    filestore_wbthrottle_xfs_ios_start_flusher     => 500,
    filestore_wbthrottle_xfs_bytes_start_flusher   => 50000000,
    filestore_wbthrottle_xfs_inodes_start_flusher  => 500,
    filestore_wbthrottle_enable                    => true,

    # osd recovery,
    osd_recovery_threads          => 2,
    osd_recovery_thread_timeout   => 30,
    osd_recovery_max_active       => 5,
    osd_recovery_max_single_start => 10,
    osd_recovery_max_chunk        => 33554432, # 32 MB
    osd_recovery_op_priority      => 10, # 1~63
    osd_client_op_priority        => 63,

    # osd scrub,
    osd_scrub_thread_timeout          => 60,
    osd_scrub_finalize_thread_timeout => 600,
    osd_max_scrubs                    => 1,
    osd_scrub_load_threshold          => 0.5,
    osd_scrub_min_interval            => 86400,
    osd_scrub_max_interval            => 604800,
    osd_scrub_chunk_min               => 5,
    osd_scrub_chunk_max               => 25,
    osd_deep_scrub_interval           => 604800,
    osd_deep_scrub_stride             => 524288
  }
}
