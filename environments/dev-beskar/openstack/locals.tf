locals {
  ostack_region_name = "Brno1"
  ostack_zone_name = "nova"

  ostack_aggregate_crf_e1_hosts = [
    "crf-001-ics.priv.cld.democluster.dev",
    "crf-002-ics.priv.cld.democluster.dev",
    "crf-003-ics.priv.cld.democluster.dev",
    "crf-007-ics.priv.cld.democluster.dev",
    "crf-008-ics.priv.cld.democluster.dev",
    "service-001.priv.cld.democluster.dev",
  ]
  ostack_aggregate_crf_c2_g2_hosts = [
    "crf-004-ics.priv.cld.democluster.dev",
    "crf-009-ics.priv.cld.democluster.dev",
    "crf-010-ics.priv.cld.democluster.dev",
    "crf-006-ics.priv.cld.democluster.dev",
  ]
  ostack_aggregate_crf_c3_hosts = [
    "crf-005-ics.priv.cld.democluster.dev",
    "crf-011-ics.priv.cld.democluster.dev",
    "crf-012-ics.priv.cld.democluster.dev",
    "crf-014-ics.priv.cld.democluster.dev",
  ]
  ostack_aggregate_crf_p3_r3_hosts = [
    "crf-013-ics.priv.cld.democluster.dev",
  ]
  ostack_aggregate_mem_c3_hosts = [ ]
  ostack_aggregate_mem_p3_r3_hosts = [
    "mem-001-meta.priv.cld.democluster.dev",
  ]

  shell_ostack_mapping_script_dir = var.shell_ostack_mapping_script_dir
  shell_ostack_mapping_create = file("${var.shell_ostack_mapping_script_dir}/create.sh")
  shell_ostack_mapping_read = file("${var.shell_ostack_mapping_script_dir}/read.sh")
  shell_ostack_mapping_update = file("${var.shell_ostack_mapping_script_dir}/update.sh")
  shell_ostack_mapping_delete = file("${var.shell_ostack_mapping_script_dir}/delete.sh")

  ostack_flavor_c2_disk_size = "80"
  ostack_flavor_c2_extra_specs = {
    "hw_rng:allowed" = "true",
    "hw_rng:rate_bytes" = "2048",
    "hw_rng:rate_period" = "1",
    "quota:disk_total_bytes_sec" = "2097152000",
    "quota:disk_total_iops_sec" = "3000",
    "quota:vif_inbound_average" = "2097152",
    "quota:vif_outbound_average" = "2097152",
    "aggregate_instance_extra_specs:flavor" = "c2",
  }

  ostack_flavor_c3_disk_size = "80"
  ostack_flavor_c3_extra_specs = {
    "hw_rng:allowed" = "true",
    "hw_rng:rate_bytes" = "2048",
    "hw_rng:rate_period" = "1",
    "quota:disk_total_bytes_sec" = "2097152000",
    "quota:disk_total_iops_sec" = "3000",
    "quota:vif_inbound_average" = "10485760",
    "quota:vif_outbound_average" = "10485760",
    "aggregate_instance_extra_specs:flavor" = "c3",
  }

  ostack_flavor_p3_disk_size = "80"
  ostack_flavor_p3_ephemeral_disk_size = "80"
  ostack_flavor_p3_extra_specs = {
    "hw_rng:allowed" = "true",
    "hw_rng:rate_bytes" = "2048",
    "hw_rng:rate_period" = "1",
    "quota:vif_inbound_average" = "20480000",
    "quota:vif_outbound_average" = "20480000",
    "aggregate_instance_extra_specs:flavor" = "p3",
  }

  ostack_flavor_g2_disk_size = "80"
  ostack_flavor_g2_extra_specs = {
    "hw_rng:allowed" = "true",
    "hw_rng:rate_bytes" = "2048",
    "hw_rng:rate_period" = "1",
    "quota:disk_total_bytes_sec" = "1048576000",
    "quota:disk_total_iops_sec" = "2000",
    "quota:vif_inbound_average" = "524288",
    "quota:vif_outbound_average" = "524288",
    "aggregate_instance_extra_specs:flavor" = "g2",
  }

  ostack_flavor_e1_disk_size = "80"
  ostack_flavor_e1_extra_specs = {
    "hw_rng:allowed" = "true",
    "hw_rng:rate_bytes" = "2048",
    "hw_rng:rate_period" = "1",
    "quota:disk_total_bytes_sec" = "262144000",
    "quota:disk_total_iops_sec" = "2000",
    "quota:vif_inbound_average" = "256000",
    "quota:vif_outbound_average" = "256000",
    "aggregate_instance_extra_specs:flavor" = "e1",
  }

  ostack_flavor_r3_disk_size = "80"
  ostack_flavor_r3_small_disk_size = "30"
  ostack_flavor_r3_ephemeral_disk_size = "80"
  ostack_flavor_r3_small_ephemeral_disk_size = "30"
  ostack_flavor_r3_extra_specs = {
    "hw_rng:allowed" = "true",
    "hw_rng:rate_bytes" = "2048",
    "hw_rng:rate_period" = "1",
    "quota:vif_inbound_average" = "20480000",
    "quota:vif_outbound_average" = "20480000",
    "aggregate_instance_extra_specs:flavor" = "r3",
  }
  permanent_floating_ip_description = "floating ip address permanently granted by a ostack project"
}
