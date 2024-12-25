###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

####

variable "service_account_key_file" {
  type = string
}

variable "vm_web_image" {
  type = string
} 

variable "vm_web_platform" {
  type = string
}

variable "vm_resources" {
    type = map(object({
        cores = number
        memory = number
        fraction = number
    }))
# var setup moved to personal.auto.tfvars
#    default = {
#        0 = {
#            cores = 4
#            memory = 4
#            fraction = 20
#        }
#        1 = {
#            cores = 2
#            memory = 1
#            fraction = 20 
#        }
#    }
}

variable "web_disk_count" {
  type = number
}

variable "vm_scheduler" {
  type = bool
}

variable "vm_nat" {
  type = bool
}

#variable "vm_index" {
#  type=number
#}

variable "vm_foreach" {
  type = map(object({
    name = string, 
    cores = number, 
    memory = number,
    fraction = number, 
    disk = number }))
}

### disk_vm.tf
variable "storage_vm_name" {
  type = string
}

variable "storage_disk_size" {
  type = number
}

variable "vm_storage_platform" {
  type = string
}

variable "vm_storage_image"{
  type = string
}

variable "storage_resources" {
    type = map
}
variable "disk_foreach" {
    type = set(string)
}
variable "disk_autodelete"{
  type = bool
}
variable "storage_disk_count" {
  type = number
}