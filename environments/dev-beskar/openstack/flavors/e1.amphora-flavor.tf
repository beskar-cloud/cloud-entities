resource "openstack_compute_flavor_v2" "e1_amphora" {
  name        = "e1.amphora"
  description = "flavor exlusively for octavia amphorae"
  ram         = "1024"
  vcpus       = "1"
  disk        = "2"
  is_public   = false
  extra_specs = local.ostack_flavor_e1_extra_specs
}
