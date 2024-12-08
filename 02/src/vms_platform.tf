variable "org"{
    type = string
    default = "netology"
}
variable "env" {
    type = string
    default = "develop"
}

variable "platform" {
    type = string
    default = "platform"
}

variable "vms_resources" {
    type = map(object({
        cores = number
        memory = number
        fraction = number
    }))
    default = {
        web = {
            cores = 2
            memory = 1
            fraction = 20
        }
        db = {
            cores = 2
            memory = 2
            fraction = 20 
        }
    }
}

variable "vms_metadata" {
    type = map(object({
        serial = number
        ssh-key = string
    }))
    default = {
        metadata={
            serial = 1
            ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP64OASkIOXR6sm45n3pkCksqA+JImYGrEGm2aQ0lafK mikhail@mongoose" 
        }
    }
}

### VM_WEB
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image for VM"
} 

#variable "vm_web_name" {
#  type = string
#  default = "netology-develop-platform-web"
#}

variable "vm_web_platform" {
  type = string
  default = "standard-v3"
}

#variable "vm_web_resources" {
#  type = object({
#    cores = number
#    memory = number
#    core_fraction =number
#  })
#  default = {
#    cores = 2
#    memory = 1
#    core_fraction = 20
#  }
#}

variable "vm_web_scheduler" {
  type = bool
  default = true
}

variable "vm_web_nat"{
  type = bool
  default = true
}

#variable "vm_web_serial" {
#  type = number
#  default = 1
#}

###VM_DB
variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image for VM"
} 

#variable "vm_db_name" {
#  type = string
#  default = "netology-develop-platform-db"
#}

variable "vm_db_platform" {
  type = string
  default = "standard-v3"
}

#variable "vm_db_resources" {
#  type = object({
#    cores = number
#    memory = number
#    core_fraction =number
#  })
#  default = {
#    cores = 2
#    memory = 2
#    core_fraction = 20
#  }
#}

variable "vm_db_scheduler" {
  type = bool
  default = true
}

variable "vm_db_nat"{
  type = bool
  default = true
}

#variable "vm_db_serial" {
#  type = number
#  default = 1
#}