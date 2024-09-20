resource "openstack_compute_flavor_v2" "g2_medium" {
  name  = "g2.medium"
  ram   = "16384"
  vcpus = "4"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_g2_extra_specs
}
