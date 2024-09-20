resource "openstack_compute_flavor_v2" "e1_8core_60ram" {
  name  = "e1.8core-60ram"
  ram   = "61440"
  vcpus = "8"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_e1_extra_specs
}
