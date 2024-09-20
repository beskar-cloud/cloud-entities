# This role assignment is needed by tight cinder <-> nova service user linking
# see https://docs.openstack.org/cinder/latest/configuration/block-storage/service-token.html and https://docs.openstack.org/releasenotes/cinder/yoga.html#upgrade-notes

# recognize user cinder in domain service (created by OpenStack cinder bootstrap)
data "openstack_identity_user_v3" "service_cinder" {
  name = "cinder"
  domain_id = data.openstack_identity_project_v3.service.id
}

# add role service to service user cinder
resource "openstack_identity_role_assignment_v3" "service_cinder_service" {
  user_id    = data.openstack_identity_user_v3.service_cinder.id
  project_id = data.openstack_identity_project_v3.service_service.id
  role_id    = openstack_identity_role_v3.service.id
}
