data "yandex_compute_image" "vm_web_image" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "web" {
  
  depends_on = [ yandex_compute_instance.db ]
  
  count = var.web_disk_count
  name = "web-${count.index + 1}"
  platform_id = var.vm_web_platform
  

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm_web_image.image_id
    }
  }

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