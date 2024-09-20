provider "openstack" {
    # auth arguments are read from environment variables (sourced openstack RC file)
}

# openstack mapping shell provider
provider "shell" {
    alias = "ostack_mapping"
    interpreter = ["/bin/bash", "-c"]
    enable_parallelism = false
}
