terraform {
  required_providers {
    shell = {
      source = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}

provider "shell" {
    environment = {
        ACTIONS_DIR = "${path.module}/.."
    }
    interpreter = ["/bin/bash", "-c"]
    enable_parallelism = false
}

resource "shell_script" "ostack_mapping" {
    lifecycle_commands {
        create = file("${path.module}/../create.sh")
        read   = file("${path.module}/../read.sh")
        update = file("${path.module}/../update.sh")
        delete = file("${path.module}/../delete.sh")
    }

    environment = {
        NAME        = "deep-hdc_mapping2"
        RULES_FILE  = "${path.module}/deep-hdc_mapping2.json"
    }

    working_directory = path.module
}

/*
output "id" {
    value = shell_script.ostack_mapping.output["id"]
}*/
