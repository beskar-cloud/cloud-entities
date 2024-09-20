resource "openstack_networking_network_v2" "internal_ipv4_general_private" {
  name           = "internal-ipv4-general-private"
  admin_state_up = true
  shared         = true
  # TODO: need to find way how to increase it to 8950
  # 19: ovs-system: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
  #  link/ether e6:62:9b:56:22:b9 brd ff:ff:ff:ff:ff:ff
  # mtu            = 8950
}
