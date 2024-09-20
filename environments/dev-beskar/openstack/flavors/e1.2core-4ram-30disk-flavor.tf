resource "openstack_compute_flavor_v2" "e1_2core_4ram_30disk" {
  name  = "e1.2core-4ram-30disk"
  ram   = "4096"
  vcpus = "2"
  disk  = "30"
  is_public = false
  extra_specs = local.ostack_flavor_e1_extra_specs
}
