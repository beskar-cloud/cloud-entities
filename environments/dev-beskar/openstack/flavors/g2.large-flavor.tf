resource "openstack_compute_flavor_v2" "g2_large" {
  name  = "g2.large"
  ram   = "16384"
  vcpus = "8"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_g2_extra_specs
}
