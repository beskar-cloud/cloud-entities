# TF variables assigned at runtime in CI/CD job

variable "shell_ostack_mapping_script_dir" {
  description = "Directory to CRUD scripts of shell.ostack_mapping provider."
  type        = string
  default     = "../ci/terraform/providers/shell/ostack_mapping"
}

# TF variables used for all secrets passed from CI/CD variable TF_ENV_VARS_FILE

variable "openstack_identity_user_v3_einfra_cz_migrator_password" {
  description = "Password of openstack_identity_user_v3.einfra_cz_migrator."
  type        = string
  sensitive   = true
}

variable "openstack_identity_user_v3_cloud_admin_ops_password" {
  description = "Password of openstack_identity_user_v3.cloud_admin_ops_password."
  type        = string
  sensitive   = true
}

variable "openstack_identity_user_v3_cloud_admin_ci_password" {
  description = "Password of openstack_identity_user_v3.cloud_admin_ci_password."
  type        = string
  sensitive   = true
}

variable "openstack_identity_user_v3_egi_accounting_password" {
  description = "Password of openstack_identity_user_v3.egi_accounting."
  type        = string
  sensitive   = true
}

variable "openstack_identity_user_v3_egi_appliances_password" {
  description = "Password of openstack_identity_user_v3.egi_appliances."
  type        = string
  sensitive   = true
}
