resource "openstack_compute_flavor_v2" "g2_1xlarge" {
  name  = "g2.1xlarge"
  ram   = "24576"
  vcpus = "8"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_g2_extra_specs
}
