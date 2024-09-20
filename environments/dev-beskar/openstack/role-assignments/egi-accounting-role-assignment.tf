
resource "openstack_identity_inherit_role_assignment_v3" "egi_accounting_reader" {
  user_id    = openstack_identity_user_v3.egi_accounting.id
  domain_id  = openstack_identity_project_v3.egi_eu.id
  role_id    = data.openstack_identity_role_v3.reader.id
}
