
resource "openstack_identity_inherit_role_assignment_v3" "einfra_cz_migrator_admin" {
  user_id    = openstack_identity_user_v3.einfra_cz_migrator.id
  domain_id  = openstack_identity_project_v3.einfra_cz.id
  role_id    = data.openstack_identity_role_v3.admin.id
}
