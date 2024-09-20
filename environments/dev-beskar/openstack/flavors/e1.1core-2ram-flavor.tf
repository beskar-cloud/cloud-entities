resource "openstack_compute_flavor_v2" "e1_1core_2ram" {
  name  = "e1.1core-2ram"
  ram   = "2048"
  vcpus = "1"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_e1_extra_specs
}
