resource "openstack_compute_flavor_v2" "g2_2core_4ram" {
  name  = "g2.2core-4ram"
  ram   = "4096"
  vcpus = "2"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_g2_extra_specs
}
