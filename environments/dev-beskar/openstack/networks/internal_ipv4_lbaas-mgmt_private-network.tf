resource "openstack_networking_network_v2" "internal_ipv4_lbaas_mgmt_private" {
  name           = "internal-ipv4-lbaas-mgmt-private"
  description    = "dedicated network for octavia amphorae"
  admin_state_up = true
  shared         = false
}
