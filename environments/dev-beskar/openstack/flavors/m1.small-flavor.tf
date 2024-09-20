# existing flavor (disabling, not matching flavor naming conventions)
resource "openstack_compute_flavor_v2" "m1_small" {
  name  = "m1.small"
  vcpus = "1"
  ram   = "2048"
  disk  = "20"
  is_public = false
}
