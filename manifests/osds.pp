class ceph::osds($args, $defaults = {}) {
  create_resources(ceph::osd, $args, $defaults)
}
