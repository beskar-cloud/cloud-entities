resource "openstack_compute_flavor_v2" "c3_4core_8ram" {
  name  = "c3.4core-8ram"
  ram   = "8192"
  vcpus = "4"
  disk  = local.ostack_flavor_c3_disk_size
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
