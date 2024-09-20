resource "openstack_compute_flavor_v2" "c2_18core_45ram" {
  name  = "c2.18core-45ram"
  ram   = "46080"
  vcpus = "18"
  disk  = local.ostack_flavor_c2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c2_extra_specs
}
