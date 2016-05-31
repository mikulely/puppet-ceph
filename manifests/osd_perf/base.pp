class ceph::osd_perf::base {
  $perf_options = {
    # osd op
    osd_op_threads               => 'default',
    osd_op_thread_timeout        => 'default',
    osd_op_complaint_time        => 10,

    # osd leveldb
    osd_leveldb_write_buffer_size=> 'default',
    osd_leveldb_cache_size       => 'default',
    osd_leveldb_block_size       => 'default',
    osd_leveldb_bloom_size       => 'default',
    osd_leveldb_max_open_files   => 'default', 
    osd_leveldb_compression      => 'default', 
    osd_leveldb_paranoid         => 'default', 

    # osd journal
    osd_journal_size             => 'default', 
    journal_queue_max_ops        => 'default', 
    journal_queue_max_bytes      => 'default', 
    journal_max_write_bytes      => 'default', 
    journal_max_write_entries    => 'default', 

    # osd filestore
    filestore_op_threads              => 'default',
    filestore_queue_max_ops           => 'default',
    filestore_queue_max_bytes         => 'default',
    filestore_queue_committing_max_ops=> 'default',
    filestore_max_inline_xattr_size   => 'default',
    filestore_max_inline_xattrs       => 'default',
    filestore_xattr_use_omap          => 'default',
    filestore_fd_cache_size           => 'default',
    filestore_fd_cache_random         => true,  # we custom option
    filestore_max_sync_interval       => 'default',
    filestore_min_sync_interval       => 'default',
    filestore_omap_header_cache_size  => 'default',
    filestore_fiemap                  => 'default',

    # osd message
    osd_client_message_cap            => 'default', 
    osd_client_message_size_cap       => 'default', 
    ms_dispatch_throttle_bytes        => 'default', 

    # osd filestore wbthrottle
    filestore_wbthrottle_xfs_ios_hard_limit        => 'default', 
    filestore_wbthrottle_xfs_bytes_hard_limit      => 'default', 
    filestore_wbthrottle_xfs_inodes_hard_limit     => 'default', 
    filestore_wbthrottle_xfs_ios_start_flusher     => 'default', 
    filestore_wbthrottle_xfs_bytes_start_flusher   => 'default', 
    filestore_wbthrottle_xfs_inodes_start_flusher  => 'default', 
    filestore_wbthrottle_enable                    => 'default', 

    # osd recovery
    osd_recovery_threads          => 'default',
    osd_recovery_thread_timeout   => 'default',
    osd_recovery_max_active       => 'default',
    osd_recovery_max_single_start => 'default',
    osd_recovery_max_chunk        => 'default',
    osd_recovery_op_priority      => 'default',
    osd_client_op_priority        => 'default',

    # osd scrub
    osd_scrub_thread_timeout          => 'default',
    osd_scrub_finalize_thread_timeout => 'default',
    osd_max_scrubs                    => 'default',
    osd_scrub_load_threshold          => 'default',
    osd_scrub_min_interval            => 'default',
    osd_scrub_max_interval            => 'default',
    osd_scrub_chunk_min               => 'default',
    osd_scrub_chunk_max               => 'default',
    osd_deep_scrub_interval           => 'default',
    osd_deep_scrub_stride             => 'default',
  }
}
