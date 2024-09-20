# This role is needed by tight cinder <-> nova service user linking
# see https://docs.openstack.org/cinder/latest/configuration/block-storage/service-token.html and https://docs.openstack.org/releasenotes/cinder/yoga.html#upgrade-notes
resource "openstack_identity_role_v3" "service" {
  name = "service"
}
