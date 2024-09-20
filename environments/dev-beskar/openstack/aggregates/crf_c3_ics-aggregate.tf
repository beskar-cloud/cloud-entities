resource "openstack_compute_aggregate_v2" "crf_c3_ics" {
  name     = "crf-c3-ics.priv.cld.democluster.dev"
  metadata = {
    flavor = "c3"
  }
  region   = local.ostack_region_name
  zone     = local.ostack_zone_name
  hosts    = local.ostack_aggregate_crf_c3_hosts
}
