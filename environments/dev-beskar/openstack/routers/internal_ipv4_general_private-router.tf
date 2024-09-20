resource "openstack_networking_router_v2" "internal_ipv4_general_private" {
  name                = "internal-ipv4-general-private"
  admin_state_up      = true
  external_network_id = "${openstack_networking_network_v2.external_ipv4_general_public.id}"
  enable_snat         = true
}

resource "openstack_networking_router_interface_v2" "internal_ipv4_general_private" {
  router_id = "${openstack_networking_router_v2.internal_ipv4_general_private.id}"
  subnet_id = "${openstack_networking_subnet_v2.internal_ipv4_general_private_172_16_0_0.id}"
}
