resource "openstack_compute_flavor_v2" "g2_tiny" {
  name  = "g2.tiny"
  ram   = "8192"
  vcpus = "2"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_g2_extra_specs
}
