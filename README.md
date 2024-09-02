# homelab-ansible-k3s-init

K3s cluster init with pre-installed components as:
 - Metallb
 - Helm support
 - Cert-Manager
 - RancherOrchiestrator
 - Longhorn

## TODO:
- [X] Install Longhorn on the server
- [X] Provide support for installation on multiple VMs
- [ ] Implement error handling during the installation process
- [ ] Pretasks for Vagrant boxes (updating repos)
- [ ] Vagrantfile plugin requirements handling

## Future TODO:
- [ ] Implement Extra Node for ETCD
- [ ] Taint server node

## Environment specification

✅ **Test Environment:** All components have been successfully tested on the cloud base image of **Ubuntu Server 22.04 LTS**.

✅ **Deployment Server:** The deployment server has been configured using **WSL 2** with **Ubuntu 22.04 LTS** as the operating system.

❗ **Terraform & Proxmox:** When using Terraform in conjunction with Proxmox, it is required to create a cloud-init from the Proxmox interface, following the documentation [Click here](https://pve.proxmox.com/wiki/Cloud-Init_Support) and [Ubuntu Cloud repository](https://cloud-images.ubuntu.com/jammy/current/).

Short version of Proxmox Cloud Template perparation:
 ```bash
qm create 5000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
cd /var/lib/vz/template/iso/
qm importdisk 5000 lunar-server-cloudimg-amd64-disk-kvm.img <YOUR STORAGE HERE>
qm set 5000 --scsihw virtio-scsi-pci --scsi0 <YOUR STORAGE HERE>:vm-5000-disk-0
qm set 5000 --ide2 <YOUR STORAGE HERE>:cloudinit
qm set 5000 --boot c --bootdisk scsi0
qm set 5000 --serial0 socket --vga serial0
```

## Software requirements

| Software   | Version    |
|:----------:|:----------:|
| Proxmox    |     8      |
| Ansible    |     Core 2.16.10       |
| Terraform  |     v1.9.4       |

## Cluster Network Topology
| Role       | IP              |
|:----------:|:---------------:|
| server     |     10.0.0.10   |
| agent      |     10.0.0.21   |
| agent      |     10.0.0.22   |

### Installation

Terraform Installation for Ubuntu 22.04 LTS:
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
Ansible Installation for Ubuntu 22.04 LTS:
```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

### Run Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

### Run Ansible
#### Proxmox hosts
```bash
cd ansible
ansible-playbook -i inventories/proxmox playbook.yml
```

#### Vagrant hosts
```bash
cd ansible
ansible-playbook -i inventories/vagrant playbook.yml
```

Depending on the operating system of the deploy server, there may be a problem with the public key for authentication to the selected node. Change permissions in the event of a `ssh key is too open` error.
```bash
chmod 0400 ./ansible/[your-key]
```

## For Vagrant deployment:
- [Vagrant support](./vagrant/README.md)

## More information:
- [k3s-init role](./ansible/roles/k3s-init/README.md)
- [k3s-components role](./ansible/roles/k3s-components/README.md)
