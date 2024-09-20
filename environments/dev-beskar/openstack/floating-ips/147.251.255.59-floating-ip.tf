resource "openstack_networking_floatingip_v2" "fip_147_251_255_59" {
  tenant_id   = openstack_identity_project_v3.einfra_cz_admin.id
  pool        = openstack_networking_network_v2.external_ipv4_general_public.name
  address     = "147.251.255.59"

  # ignore any changes made by end user to FIP description
  lifecycle {
    ignore_changes = [
      description,
    ]
  }
}
