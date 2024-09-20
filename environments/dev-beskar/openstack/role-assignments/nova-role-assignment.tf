# This role assignment is needed by tight cinder <-> nova service user linking
# see https://docs.openstack.org/cinder/latest/configuration/block-storage/service-token.html and https://docs.openstack.org/releasenotes/cinder/yoga.html#upgrade-notes

# recognize user nova in domain service (created by OpenStack nova bootstrap)
data "openstack_identity_user_v3" "service_nova" {
  name = "nova"
  domain_id = data.openstack_identity_project_v3.service.id
}

# add role service to service user nova
resource "openstack_identity_role_assignment_v3" "service_nova_service" {
  user_id    = data.openstack_identity_user_v3.service_nova.id
  project_id = data.openstack_identity_project_v3.service_service.id
  role_id    = openstack_identity_role_v3.service.id
}
