resource "openstack_compute_flavor_v2" "p3_16core_30ram" {
  name  = "p3.16core-30ram"
  ram   = "30720"
  vcpus = "16"
  disk  = local.ostack_flavor_p3_disk_size
  ephemeral = local.ostack_flavor_p3_ephemeral_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_p3_extra_specs
}
