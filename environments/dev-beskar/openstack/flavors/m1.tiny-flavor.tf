# existing flavor (disabling, not matching flavor naming conventions)
resource "openstack_compute_flavor_v2" "m1_tiny" {
  name  = "m1.tiny"
  vcpus = "1"
  ram   = "512"
  disk  = "1"
  is_public = false
}
