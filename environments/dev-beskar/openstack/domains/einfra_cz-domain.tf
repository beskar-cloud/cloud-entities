resource "openstack_identity_project_v3" "einfra_cz" {
  name        = "einfra_cz"
  description = "e-INFRA.CZ domain"
  enabled     = true
  is_domain   = true
}
