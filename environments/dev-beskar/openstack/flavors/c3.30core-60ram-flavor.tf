resource "openstack_compute_flavor_v2" "c3_30core_60ram" {
  name  = "c3.30core-60ram"
  ram   = "61440"
  vcpus = "30"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
