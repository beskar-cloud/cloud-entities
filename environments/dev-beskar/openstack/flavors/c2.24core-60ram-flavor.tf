resource "openstack_compute_flavor_v2" "c2_24core_60ram" {
  name  = "c2.24core-60ram"
  ram   = "61440"
  vcpus = "24"
  disk  = local.ostack_flavor_c2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c2_extra_specs
}
