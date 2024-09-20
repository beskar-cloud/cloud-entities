resource "openstack_compute_flavor_v2" "c2_20core_240ram" {
  name  = "c2.20core-240ram"
  ram   = "245760"
  vcpus = "20"
  disk  = local.ostack_flavor_c2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c2_extra_specs
}
