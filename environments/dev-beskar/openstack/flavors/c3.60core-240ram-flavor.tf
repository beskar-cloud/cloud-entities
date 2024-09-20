resource "openstack_compute_flavor_v2" "c3_60core_240ram" {
  name  = "c3.60core-240ram"
  ram   = "245760"
  vcpus = "60"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
