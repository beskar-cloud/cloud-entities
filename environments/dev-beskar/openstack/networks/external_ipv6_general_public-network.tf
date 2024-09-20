resource "openstack_networking_network_v2" "external_ipv6_general_public" {
  name                = "external-ipv6-general-public"
  admin_state_up      = true
  shared              = true
  # external_ipv6_general_public is internal network with associated router
  # this is required in order to make SLAAC working (slaac/slaac with internal radvd)
  # https://docs.openstack.org/neutron/yoga/admin/config-ipv6.html
  external            = false
  mtu                 = 8950
  segments {
    physical_network  = "provider"
    segmentation_id   = 59
    network_type      = "vlan"
  }
}
