resource "openstack_compute_flavor_v2" "g2_1core_4ram" {
  name  = "g2.1core-4ram"
  ram   = "4096"
  vcpus = "1"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_g2_extra_specs
}
