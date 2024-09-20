resource "openstack_identity_user_v3" "egi_accounting" {
  name               = "egi-accounting"
  domain_id          = "${openstack_identity_project_v3.egi_eu.id}"
  enabled            = true
  password           = var.openstack_identity_user_v3_egi_accounting_password
}
