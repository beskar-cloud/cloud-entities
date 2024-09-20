resource "openstack_identity_user_v3" "einfra_cz_migrator" {
  name               = "einfra_cz_migrator"
  domain_id          = "${openstack_identity_project_v3.einfra_cz.id}"
  enabled            = true
  password           = var.openstack_identity_user_v3_einfra_cz_migrator_password
}
