resource "openstack_compute_flavor_v2" "p3_16core_60ram_500edisk" {
  name  = "p3.16core-60ram-500edisk"
  ram   = "61440"
  vcpus = "16"
  disk  = local.ostack_flavor_p3_disk_size
  ephemeral = "500"
  is_public = false
  extra_specs = local.ostack_flavor_p3_extra_specs
}
