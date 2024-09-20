resource "openstack_identity_project_v3" "egi_eu" {
  name        = "egi_eu"
  description = "egi.eu domain (EGI Check-in)"
  enabled     = true
  is_domain   = true
}
