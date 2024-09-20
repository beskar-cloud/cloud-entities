resource "openstack_compute_flavor_v2" "e1_2xlarge" {
  name  = "e1.2xlarge"
  ram   = "16384"
  vcpus = "8"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_e1_extra_specs
}
