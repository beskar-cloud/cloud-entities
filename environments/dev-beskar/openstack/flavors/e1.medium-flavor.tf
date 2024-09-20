resource "openstack_compute_flavor_v2" "e1_medium" {
  name  = "e1.medium"
  ram   = "4096"
  vcpus = "4"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_e1_extra_specs
}
