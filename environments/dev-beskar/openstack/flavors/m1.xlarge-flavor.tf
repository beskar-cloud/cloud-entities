# existing flavor (disabling, not matching flavor naming conventions)
resource "openstack_compute_flavor_v2" "m1_xlarge" {
  name  = "m1.xlarge"
  vcpus = "8"
  ram   = "16384"
  disk  = "160"
  is_public = false
}
