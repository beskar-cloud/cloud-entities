resource "openstack_compute_flavor_v2" "p3_4core_16ram_500edisk" {
  name  = "p3.4core-16ram-500edisk"
  ram   = "16384"
  vcpus = "4"
  disk  = local.ostack_flavor_p3_disk_size
  ephemeral = "500"
  is_public = false
  extra_specs = local.ostack_flavor_p3_extra_specs
}
