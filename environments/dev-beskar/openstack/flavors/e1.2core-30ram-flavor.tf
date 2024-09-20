resource "openstack_compute_flavor_v2" "e1_2core_30ram" {
  name  = "e1.2core-30ram"
  ram   = "30720"
  vcpus = "2"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_e1_extra_specs
}
