resource "openstack_compute_flavor_v2" "p3_30core_120ram_500edisk" {
  name  = "p3.30core-120ram-500edisk"
  ram   = "122880"
  vcpus = "30"
  disk  = local.ostack_flavor_p3_disk_size
  ephemeral = "500"
  is_public = false
  extra_specs = local.ostack_flavor_p3_extra_specs
}
