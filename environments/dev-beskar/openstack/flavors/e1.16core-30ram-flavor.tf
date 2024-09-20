resource "openstack_compute_flavor_v2" "e1_16core_30ram" {
  name  = "e1.16core-30ram"
  ram   = "30720"
  vcpus = "16"
  disk  = local.ostack_flavor_e1_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_e1_extra_specs
}
