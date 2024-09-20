resource "openstack_compute_flavor_v2" "r3_8core_16ram" {
  name  = "r3.8core-16ram"
  ram   = "16384"
  vcpus = "8"
  disk  = local.ostack_flavor_r3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_r3_extra_specs
}