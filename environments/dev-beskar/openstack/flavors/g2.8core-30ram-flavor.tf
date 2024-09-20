resource "openstack_compute_flavor_v2" "g2_8core_30ram" {
  name  = "g2.8core-30ram"
  ram   = "30720"
  vcpus = "8"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_g2_extra_specs
}
