resource "openstack_compute_flavor_v2" "g2_2xlarge" {
  name  = "g2.2xlarge"
  ram   = "30720"
  vcpus = "16"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_g2_extra_specs
}
