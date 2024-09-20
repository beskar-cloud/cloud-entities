resource "openstack_compute_flavor_v2" "p3_2core_8ram" {
  name  = "p3.2core-8ram"
  ram   = "8192"
  vcpus = "2"
  disk  = local.ostack_flavor_p3_disk_size
  ephemeral = local.ostack_flavor_p3_ephemeral_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_p3_extra_specs
}
