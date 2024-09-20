resource "openstack_compute_flavor_v2" "g2_4core_30ram" {
  name  = "g2.4core-30ram"
  ram   = "30720"
  vcpus = "4"
  disk  = local.ostack_flavor_g2_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_g2_extra_specs
}
