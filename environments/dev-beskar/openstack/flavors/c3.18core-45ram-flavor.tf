resource "openstack_compute_flavor_v2" "c3_18core_45ram" {
  name  = "c3.18core-45ram"
  ram   = "46080"
  vcpus = "18"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
