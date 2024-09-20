resource "openstack_compute_flavor_v2" "c2_1core_2ram" {
  name  = "c2.1core-2ram"
  ram   = "2048"
  vcpus = "1"
  disk  = local.ostack_flavor_c2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c2_extra_specs
}
