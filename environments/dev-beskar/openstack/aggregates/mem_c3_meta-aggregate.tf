resource "openstack_compute_aggregate_v2" "mem_c3_meta" {
  name     = "mem-c3-meta.priv.cld.democluster.dev"
  metadata = {
    flavor = "c3"
  }
  region   = local.ostack_region_name
  zone     = local.ostack_zone_name
  hosts    = local.ostack_aggregate_mem_c3_hosts
}
