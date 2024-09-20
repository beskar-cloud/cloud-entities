resource "openstack_compute_flavor_v2" "c3_8core_8ram_100disk" {
  name  = "c3.8core-8ram-100disk"
  ram   = "8192"
  vcpus = "8"
  disk  = "100"
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
