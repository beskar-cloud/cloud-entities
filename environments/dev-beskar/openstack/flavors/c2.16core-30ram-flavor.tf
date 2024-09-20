resource "openstack_compute_flavor_v2" "c2_16core_30ram" {
  name  = "c2.16core-30ram"
  ram   = "30720"
  vcpus = "16"
  disk  = local.ostack_flavor_c2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c2_extra_specs
}
