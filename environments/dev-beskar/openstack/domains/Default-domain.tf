resource "openstack_identity_project_v3" "Default" {
  name        = "Default"
  description = "The default domain"
  enabled     = true
  is_domain   = true
}
