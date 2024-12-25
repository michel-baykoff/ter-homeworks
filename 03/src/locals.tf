locals {
    ssh_key = file("~/.ssh/id_rsa.pub")
#    is_iterable = yandex_compute_instance.storage != null ? type(yandex_compute_instance.storage) == map(any) || type(yandex_compute_instance.storage) == list(any) : false
}