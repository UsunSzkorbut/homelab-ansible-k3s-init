resource "proxmox_vm_qemu" "cloud-k3s-master" {
    target_node = "homelab"
    desc = "Cloud Ubuntu 22.04"
    count = 1
    onboot = true

    clone = "ubuntu-cloud"
    agent = 0

    os_type = "cloud-init"
    cores = 2
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 8096
    name = "k3s-master-0${count.index + 1}"

    scsihw   = "virtio-scsi-single" 
    bootdisk = "scsi0"
    disks {
        scsi {
            scsi0 {
                disk {
                  storage = "local-lvm"
                  emulatessd = true
                  size = 150
                }
            }
        }
        ide {
            ide3 {
                cloudinit {
                  storage = "local-lvm"
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }
    ipconfig0 = "ip=10.0.0.10/24,gw=10.0.0.1"
}

# resource "proxmox_vm_qemu" "cloud-k3s-worker" {
#     target_node = "homelab"
#     desc = "Cloud Ubuntu 22.04"
#     count = 2
#     onboot = true

#     clone = "ubuntu-cloud"
#     agent = 0

#     os_type = "cloud-init"
#     cores = 2
#     sockets = 1
#     vcpus = 0
#     cpu = "host"
#     memory = 5096
#     name = "k3s-worker-0${count.index + 1}"

#     scsihw   = "virtio-scsi-single" 
#     bootdisk = "scsi0"
#     disks {
#         scsi {
#             scsi0 {
#                 disk {
#                   storage = "local-lvm"
#                   emulatessd = true
#                   size = 150
#                 }
#             }
#         }
#         ide {
#             ide3 {
#                 cloudinit {
#                   storage = "local-lvm"
#                 }
#             }
#         }
#     }

#     network {
#         model = "virtio"
#         bridge = "vmbr0"
#     }
#     ipconfig0 = "ip=10.0.0.2${count.index + 1}/24,gw=10.0.0.1"
# }
