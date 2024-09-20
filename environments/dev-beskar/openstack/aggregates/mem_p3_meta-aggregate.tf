resource "openstack_compute_aggregate_v2" "mem_p3_meta" {
  name     = "mem-p3-meta.priv.cld.democluster.dev"
  metadata = {
    flavor = "p3"
  }
  region   = local.ostack_region_name
  zone     = local.ostack_zone_name
  hosts    = local.ostack_aggregate_mem_p3_r3_hosts
}
