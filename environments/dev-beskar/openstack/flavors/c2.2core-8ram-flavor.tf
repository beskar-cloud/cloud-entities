resource "openstack_compute_flavor_v2" "c2_2core_8ram" {
  name  = "c2.2core-8ram"
  ram   = "8192"
  vcpus = "2"
  disk  = local.ostack_flavor_c2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c2_extra_specs
}
