# OpenStack pre-defined role (once Octavia is installed)
data "openstack_identity_role_v3" "load_balancer_observer" {
  name = "load-balancer_observer"
}
