class ceph::mons($args, $defaults = {}) {
  create_resources(ceph::mon, $args, $defaults)
}
