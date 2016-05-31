class ceph::osd_perf (
  $disk_type = 'ssd',
) inherits ceph {

  # get base options
  include ceph::osd_perf::base
  $base_options = $ceph::osd_perf::base::perf_options


  # get tune options for the disk type
  case $disk_type {
    ssd: {
      include ceph::osd_perf::ssd
      $tune_opts = $ceph::osd_perf::ssd::perf_options
    }
    sata: {
      include ceph::osd_perf::sata
      $tune_opts = $ceph::osd_perf::sata::perf_options
    }
    default: {
      fail("This module does not support ${disk_type} disk type!")
    }
  }

  # set osd performance options in ceph.conf
  $base_options.each |$key, $val| {
    # the first priority is ceph class
    $set_val = inline_template("<%= scope.lookupvar('ceph::$key') %>")

    # the second priority is ceph::osd_perf::{disk_type} class
    $tune_val = $tune_opts[$key]

    # the third priority is ceph::osd_perf::base class
    if $set_val != undef and $set_val != 'undef' {
      $really_val = $set_val  
    } elsif $tune_val != undef and $tune_val != 'undef' {
      $really_val = $tune_val
    } else {
      $really_val = $val
    }

    # set options in ceph.conf
    ceph_config {
      "osd/${key}":   value => $really_val;
    }
  }



}
