resource "openstack_compute_flavor_v2" "p3_24core_60ram_500edisk" {
  name  = "p3.24core-60ram-500edisk"
  ram   = "61440"
  vcpus = "24"
  disk  = local.ostack_flavor_p3_disk_size
  ephemeral = "500"
  is_public = false
  extra_specs = local.ostack_flavor_p3_extra_specs
}
