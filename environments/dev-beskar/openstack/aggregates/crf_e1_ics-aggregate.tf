resource "openstack_compute_aggregate_v2" "crf_e1_ics" {
  name     = "crf-e1-ics.priv.cld.democluster.dev"
  metadata = {
    flavor = "e1"
  }
  region   = local.ostack_region_name
  zone     = local.ostack_zone_name
  hosts    = local.ostack_aggregate_crf_e1_hosts
}
