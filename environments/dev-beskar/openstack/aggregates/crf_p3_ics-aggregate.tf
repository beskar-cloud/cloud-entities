resource "openstack_compute_aggregate_v2" "crf_p3_ics" {
  name     = "crf-p3-ics.priv.cld.democluster.dev"
  metadata = {
    flavor = "p3"
  }
  region   = local.ostack_region_name
  zone     = local.ostack_zone_name
  hosts    = local.ostack_aggregate_crf_p3_r3_hosts
}
