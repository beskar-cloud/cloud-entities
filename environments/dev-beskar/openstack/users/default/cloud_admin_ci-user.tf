resource "openstack_identity_user_v3" "cloud_admin_ci" {
  name               = "cloud_admin_ci"
  domain_id          = "${openstack_identity_project_v3.Default.id}"
  enabled            = true
  password           = var.openstack_identity_user_v3_cloud_admin_ci_password
}
