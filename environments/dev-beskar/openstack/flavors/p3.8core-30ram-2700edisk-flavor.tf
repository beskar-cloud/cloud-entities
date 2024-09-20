resource "openstack_compute_flavor_v2" "p3_8core_30ram_2700edisk" {
  name  = "p3.8core-30ram-2700edisk"
  ram   = "30720"
  vcpus = "8"
  disk  = local.ostack_flavor_p3_disk_size
  ephemeral = "2700"
  is_public = false
  extra_specs = local.ostack_flavor_p3_extra_specs
}
