# recognize service domain (created by deployed OpenStack components)
data "openstack_identity_project_v3" "service" {
  name = "service"
  is_domain = true
}

# recognize project service in domain service (created by deployed OpenStack components)
data "openstack_identity_project_v3" "service_service" {
  name = "service"
  domain_id = data.openstack_identity_project_v3.service.id
}
