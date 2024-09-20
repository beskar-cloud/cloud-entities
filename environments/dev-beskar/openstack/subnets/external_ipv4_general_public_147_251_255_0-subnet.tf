resource "openstack_networking_subnet_v2" "external_ipv4_general_public_147_251_255_0" {
  name            = "external-ipv4-general-public-147-251-255-0"
  network_id      = "${openstack_networking_network_v2.external_ipv4_general_public.id}"
  cidr            = "147.251.255.0/24"
  ip_version      = 4
  dns_nameservers = [ "147.251.4.33", "147.251.6.10", "8.8.8.8" ]
  gateway_ip      = "147.251.255.1"
  enable_dhcp     = "false"
}
