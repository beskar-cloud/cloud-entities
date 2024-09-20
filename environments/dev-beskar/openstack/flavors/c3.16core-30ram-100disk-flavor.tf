resource "openstack_compute_flavor_v2" "c3_16core_30ram_100disk" {
  name  = "c3.16core-30ram-100disk"
  ram   = "30720"
  vcpus = "16"
  disk  = "100"
  is_public = false
  extra_specs = local.ostack_flavor_c3_extra_specs
}
