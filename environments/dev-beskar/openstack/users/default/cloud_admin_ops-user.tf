resource "openstack_identity_user_v3" "cloud_admin_ops" {
  name               = "cloud_admin_ops"
  domain_id          = "${openstack_identity_project_v3.Default.id}"
  enabled            = true
  password           = var.openstack_identity_user_v3_cloud_admin_ops_password
}
