resource "openstack_compute_aggregate_v2" "cln_r3" {
  name     = "crf-r3-ics.priv.cld.democluster.dev"
  metadata = {
    flavor = "r3"
  }
  region   = local.ostack_region_name
  zone     = local.ostack_zone_name
  hosts    = local.ostack_aggregate_crf_p3_r3_hosts
}