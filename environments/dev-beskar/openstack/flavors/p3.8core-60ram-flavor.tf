resource "openstack_compute_flavor_v2" "p3_8core_60ram" {
  name  = "p3.8core-60ram"
  ram   = "61440"
  vcpus = "8"
  disk  = local.ostack_flavor_p3_disk_size
  ephemeral = local.ostack_flavor_p3_ephemeral_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_p3_extra_specs
}
