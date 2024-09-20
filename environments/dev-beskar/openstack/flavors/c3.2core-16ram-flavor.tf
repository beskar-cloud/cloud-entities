resource "openstack_compute_flavor_v2" "c3_2core_16ram" {
  name  = "c3.2core-16ram"
  ram   = "16384"
  vcpus = "2"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
