data "yandex_compute_image" "vm_storage_image" {
  family = var.vm_storage_image
}

resource "yandex_compute_disk" "storage_disk" {
  count = var.storage_disk_count
  name = "disk${count.index}"
  size = var.storage_disk_size 
}

data "yandex_compute_disk" "storage_disk" {

  depends_on = [yandex_compute_disk.storage_disk]
  
  for_each = var.disk_foreach
  name = "${each.value}"
}

resource "yandex_compute_instance" "storage" {
  
  depends_on = [yandex_compute_disk.storage_disk]
  
  name = var.storage_vm_name
  platform_id = var.vm_storage_platform
  
  resources {
    cores         = var.storage_resources.cores
    memory        = var.storage_resources.memory
    core_fraction = var.storage_resources.fraction
    }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm_storage_image.image_id
    }
  }
  
  dynamic "secondary_disk" {
    #for_each = var.disk_foreach
    for_each = { for dsk in yandex_compute_disk.storage_disk[*]: dsk.name=> dsk }
    content {
      #disk_id = data.yandex_compute_disk.storage_disk[secondary_disk.value].id
      disk_id = secondary_disk.value.id
      auto_delete = var.disk_autodelete
    }

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