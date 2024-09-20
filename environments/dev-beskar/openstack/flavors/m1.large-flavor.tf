# existing flavor (disabling, not matching flavor naming conventions)
resource "openstack_compute_flavor_v2" "m1_large" {
  name  = "m1.large"
  vcpus = "4"
  ram   = "8192"
  disk  = "80"
  is_public = false
}
