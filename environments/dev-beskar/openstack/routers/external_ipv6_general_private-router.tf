# ipv6 external router providing SLAAC addressing
# see https://docs.openstack.org/neutron/yoga/admin/config-ipv6.html#user-workflow

resource "openstack_networking_router_v2" "external_ipv6_general_public" {
  name                = "external-ipv6-general-public"
  admin_state_up      = true
  distributed         = true
  # it seems ha property is not supported as of provider version 1.54.1
  # see https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_v2
  # by default router will be HA thus next line is commented out but still true
  #ha                  = true
}

# get explicit ipv6 port from net external_ipv6_general_public
resource "openstack_networking_port_v2" "external_ipv6_general_public_router_port" {
  name           = "external-ipv6-general-public-router-port"
  network_id     = openstack_networking_network_v2.external_ipv6_general_public.id  
  admin_state_up = "true"
}

# assign ipv6 port external_ipv6_general_public_p1 to router
resource "openstack_networking_router_interface_v2" "external_ipv6_general_public_i1" {
  router_id = openstack_networking_router_v2.external_ipv6_general_public.id
  #subnet_id = openstack_networking_subnet_v2.external_ipv6_general_public_2001_718_801_43b.id
  port_id   = openstack_networking_port_v2.external_ipv6_general_public_router_port.id
}

# next-hop router
resource "openstack_networking_router_route_v2" "external_ipv6_general_public_router_route" {
  router_id        = openstack_networking_router_v2.external_ipv6_general_public.id
  destination_cidr = "::/0"
  next_hop         = "2001:718:801:43b::1"
}
