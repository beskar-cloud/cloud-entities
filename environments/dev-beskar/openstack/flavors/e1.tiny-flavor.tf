resource "openstack_compute_flavor_v2" "e1_tiny" {
  name  = "e1.tiny"
  ram   = "2048"
  vcpus = "2"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_e1_extra_specs
}
