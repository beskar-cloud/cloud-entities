resource "openstack_compute_flavor_v2" "c3_2core_4ram" {
  name  = "c3.2core-4ram"
  ram   = "4096"
  vcpus = "2"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
