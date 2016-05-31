class ceph::osd_perf::sata inherits ceph::osd_perf::base {
  $perf_options = {
    #You can set some options for sata

    # osd scrub,
    osd_op_complaint_time             => 5,
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
