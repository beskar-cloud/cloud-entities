resource "openstack_networking_subnet_v2" "internal_ipv4_lbaas_mgmt_private_172_17_0_0" {
  name        = "internal-ipv4-lbaas-mgmt-private-172-17-0-0"
  description = "dedicated subnet for octavia amphorae"
  network_id  = "${openstack_networking_network_v2.internal_ipv4_lbaas_mgmt_private.id}"
  cidr        = "172.17.0.0/20"
  # Some addresses are reserved for control-plane nodes (octavia component communication)
  allocation_pool {
    start     = "172.17.0.21"
    end       = "172.17.15.254"
  }
  ip_version  = 4
  dns_nameservers = [ "147.251.4.33", "147.251.6.10", "8.8.8.8" ]
}
