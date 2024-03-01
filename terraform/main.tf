terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
}

resource "twc_ssh_key" "example-key" {
  name = "terraform-eshop-deploy-key"
  body = file("~/.ssh/id_rsa.pub")
}

data "twc_os" "os" {
  name    = "ubuntu"
  version = "22.04"
}

data "twc_presets" "master-preset" {
  disk_type = "ssd"
  cpu = 2
  price_filter {
    from = 400
    to   = 505
  }
}

data "twc_presets" "worker-preset" {
  cpu = 1
  price_filter {
    from = 100
    to   = 200
  }
}

#resource "twc_server" "master" {
#  name         = "Master"
#  preset_id    = data.twc_presets.master-preset.id
#  os_id        = data.twc_os.os.id
#  ssh_keys_ids = [twc_ssh_key.example-key.id]
#}

variable "workers-amount" {
  default = 1
}

resource "twc_server" "worker" {
  count        = var.workers-amount
  name         = "Worker-${count.index + 1}"
  preset_id    = data.twc_presets.worker-preset.id
  os_id        = data.twc_os.os.id
  ssh_keys_ids = [twc_ssh_key.example-key.id]
}


#output "master_ip" {
#  value = twc_server.master.main_ipv4
#}

output "workers_ips" {
  value = [for worker in twc_server.worker : worker.main_ipv4]
}