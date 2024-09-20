resource "openstack_compute_flavor_v2" "e1_20core_60ram" {
  name  = "e1.20core-60ram"
  ram   = "61440"
  vcpus = "20"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_e1_extra_specs
}
