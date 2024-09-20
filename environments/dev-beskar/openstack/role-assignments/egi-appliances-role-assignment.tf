resource "openstack_identity_inherit_role_assignment_v3" "egi_accounting_admin" {
  user_id    = openstack_identity_user_v3.egi_appliances.id
  domain_id  = openstack_identity_project_v3.egi_eu.id
  role_id    = data.openstack_identity_role_v3.admin.id
}

# TODO: doublecheck whether admin role on the domain is enough for cloudkeeper
