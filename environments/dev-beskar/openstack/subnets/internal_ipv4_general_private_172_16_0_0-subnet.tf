resource "openstack_networking_subnet_v2" "internal_ipv4_general_private_172_16_0_0" {
  name       = "internal-ipv4-general-private-172-16-0-0"
  network_id = "${openstack_networking_network_v2.internal_ipv4_general_private.id}"
  cidr       = "172.16.0.0/16"
  ip_version = 4
  dns_nameservers = [ "147.251.4.33", "147.251.6.10", "8.8.8.8" ]
}
