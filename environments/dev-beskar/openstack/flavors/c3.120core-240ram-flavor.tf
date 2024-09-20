resource "openstack_compute_flavor_v2" "c3_120core_240ram" {
  name  = "c3.120core-240ram"
  ram   = "245760"
  vcpus = "120"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
