resource "openstack_compute_flavor_v2" "e1_8core_30ram" {
  name  = "e1.8core-30ram"
  ram   = "30720"
  vcpus = "8"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = true
  extra_specs = local.ostack_flavor_e1_extra_specs
}
