resource "yandex_compute_instance" "db" {
    for_each = var.vm_foreach  
#    for_each = toset(["main", "replica"])

    name = "${each.value["name"]}"
    
    boot_disk {
        initialize_params {
        image_id = data.yandex_compute_image.vm_web_image.image_id
        size = each.value["disk"]
        }
    }
    
    resources {
    
        cores         = each.value["cores"]
        memory        = each.value["memory"]
        core_fraction = each.value["fraction"]
        
    }
    
    scheduling_policy {
        preemptible = var.vm_scheduler
    }
    
    network_interface {
        subnet_id       = yandex_vpc_subnet.develop.id
        nat             = var.vm_nat
    }

    metadata = {
        ssh-keys = "ubuntu:${local.ssh_key}"
  }

}