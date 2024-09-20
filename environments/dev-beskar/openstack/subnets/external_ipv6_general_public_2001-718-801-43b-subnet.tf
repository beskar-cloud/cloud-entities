resource "openstack_networking_subnet_v2" "external_ipv6_general_public_2001_718_801_43b" {
  name              = "external-ipv6-general-public-2001-718-801-43b"
  network_id        = "${openstack_networking_network_v2.external_ipv6_general_public.id}"
  cidr              = "2001:718:801:43b::/64"
  ip_version        = 6
  dns_nameservers   = [ "2001:718:801:404::33", "2001:718:801:406::10" ]
  gateway_ip        = "2001:718:801:43b::1"
  ipv6_address_mode = "slaac"
  ipv6_ra_mode      = "slaac"
  allocation_pool {
    start           = "2001:718:801:43b::8"
    end             = "2001:718:801:43b:ffff:ffff:ffff:ffff"
  }
}
