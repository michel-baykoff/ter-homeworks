data "yandex_compute_image" "vm_web_image" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "web" {
  
  depends_on = [ yandex_compute_instance.db ]
  
  count = 2
  name = "web-${count.index + 1}"
  platform_id = var.vm_web_platform
  

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm_web_image.image_id
    }
  }

# Not working
#  resources {
#    cores         = format("%s%s%s", "var.vm_resources.web-", count.index + 1, ".cores")
#    memory        = format("%s%s%s", "var.vm_resources.web-", count.index + 1, ".memory")
#    core_fraction = format("%s%s%s", "var.vm_resources.web-", count.index + 1, ".fraction")
#  }
#
#  resources {
#    cores         = var.vm_resources.${name}.cores
#    memory        = var.vm_resources.${name}.memory
#    core_fraction = var.vm_resources.${name}.fraction
#  }
#resources {
#    cores         = format("var.vm_resources.web-%s%s", count.index, ".cores")
#    memory        = format("var.vm_resources.web-%s%s", count.index, ".memory")
#    core_fraction = format("var.vm_resources.web-%s%s", count.index, ".fraction")
#  }

    resources {
        cores         = var.vm_resources[keys(var.vm_resources)[count.index]].cores
        memory        = var.vm_resources[keys(var.vm_resources)[count.index]].memory
        core_fraction = var.vm_resources[keys(var.vm_resources)[count.index]].fraction
    }

    scheduling_policy {
        preemptible = var.vm_scheduler
    }

    network_interface {
        subnet_id       = yandex_vpc_subnet.develop.id
        nat             = var.vm_nat
        security_group_ids  = [yandex_vpc_security_group.example.id]
    }

    metadata = {
        ssh-keys = "ubuntu:${local.ssh_key}"
    }

}