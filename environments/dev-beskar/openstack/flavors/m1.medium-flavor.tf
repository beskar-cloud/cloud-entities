# existing flavor (disabling, not matching flavor naming conventions)
resource "openstack_compute_flavor_v2" "m1_medium" {
  name  = "m1.medium"
  vcpus = "2"
  ram   = "4096"
  disk  = "40"
  is_public = false
}
