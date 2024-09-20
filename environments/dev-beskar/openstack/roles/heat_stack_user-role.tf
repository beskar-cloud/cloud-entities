# OpenStack pre-defined role
data "openstack_identity_role_v3" "heat_stack_user" {
  name = "heat_stack_user"
}
