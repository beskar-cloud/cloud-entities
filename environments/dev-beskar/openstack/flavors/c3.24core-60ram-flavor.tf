resource "openstack_compute_flavor_v2" "c3_24core_60ram" {
  name  = "c3.24core-60ram"
  ram   = "61440"
  vcpus = "24"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
