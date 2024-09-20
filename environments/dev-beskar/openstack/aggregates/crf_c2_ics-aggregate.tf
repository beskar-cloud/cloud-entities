resource "openstack_compute_aggregate_v2" "crf_c2_ics" {
  name     = "crf-c2-ics.priv.cld.democluster.dev"
  metadata = {
    flavor = "c2"
  }
  region   = local.ostack_region_name
  zone     = local.ostack_zone_name
  hosts    = local.ostack_aggregate_crf_c2_g2_hosts
}
