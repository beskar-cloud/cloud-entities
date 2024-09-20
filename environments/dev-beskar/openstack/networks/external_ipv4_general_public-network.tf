resource "openstack_networking_network_v2" "external_ipv4_general_public" {
  name           = "external-ipv4-general-public"
  admin_state_up = true
  shared         = false
  external       = true
  mtu            = 9000
  
  # There are multiple public networks inside single ostack segment corresponding to VLAN ID 716
  # see details in https://gitlab.ics.muni.cz/cloud/g2/infra-config/-/blob/master/extra/networks/brno.yml
  segments {
    physical_network  = "provider"
    segmentation_id   = 716
    network_type      = "vlan"
  }
  
}
