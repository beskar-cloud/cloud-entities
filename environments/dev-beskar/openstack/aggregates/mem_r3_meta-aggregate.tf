resource "openstack_compute_aggregate_v2" "mem_r3_meta" {
  name     = "mem-r3-meta.priv.cld.democluster.dev"
  metadata = {
    flavor = "r3"
  }
  region   = local.ostack_region_name
  zone     = local.ostack_zone_name
  hosts    = local.ostack_aggregate_mem_p3_r3_hosts
}
