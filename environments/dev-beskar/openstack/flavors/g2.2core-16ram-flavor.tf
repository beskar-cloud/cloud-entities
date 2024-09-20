resource "openstack_compute_flavor_v2" "g2_2core_16ram" {
  name  = "g2.2core-16ram"
  ram   = "16384"
  vcpus = "2"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_g2_extra_specs
}
