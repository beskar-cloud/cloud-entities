resource "openstack_compute_flavor_v2" "c3_16core_120ram" {
  name  = "c3.16core-120ram"
  ram   = "122880"
  vcpus = "16"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
