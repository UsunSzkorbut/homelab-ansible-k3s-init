# homelab-ansible-k3s-init

K3s cluster init with pre-installed components as:
 - Metallb
 - Helm support / on master01
 - Cert-Manager
 - Nginx Ingress Controller / Traefik is not installed
 - RancherOrchiestrator
 - Longhorn / default storage-class driver

## TODO:
#### Kubernetes
- [X] Install Longhorn on the server (with supported pkg)
- [X] Taint server - master01 node
- [X] Install Nginx Ingress Controller
- [X] Prepare Ingress for Rancher on basis of Nginx
#### Ansible
- [X] Provide support for installation on multiple VMs
- [X] Pretasks for Vagrant boxes (updating repos)
- [X] Implement Extra Node for HA
- [ ] Implement error handling during the installation process
    - [ ] Add registers for error handling
- [ ] Optimize and tag Ansible
- [ ] Update roles README
#### Vagrant
- [X] Vagrantfile plugin requirements handling

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

## Cluster Topology
| Role       | Specification    | Hostname        |IP               |
|:----------|:----------------|:---------------:|:---------------:|
| master     | Workload NoSchedule  | k3s-master-01 |     10.0.0.11   |
| master + agent     | Workload ready   | k3s-master-02 |     10.0.0.12   |
| agent      | Workload ready   | k3s-worker-01 |     10.0.0.21   |
| agent      | Workload ready   | k3s-worker-02 |     10.0.0.22   |

To balance high availability with limited resources, a 4-node cluster was set up, consisting of 2 master nodes and 2 worker nodes.

- **Master01** [k3s-master-01] serves as a dedicated control plane with an ETCD database. It ensures operational continuity in case of failure of the second master but is not configured to accept any new tasks.
- **Master02** [k3s-master-02] has an identical configuration to Master 1 but is designed to accept and manage tasks alongside its control-plane responsibilities.

This architecture ensures redundancy while maximizing resource efficiency.

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
Requires specifying the usege of Vagrant by variable `use_vagrant`, which can be set inline:
```bash
cd ansible
ansible-playbook -i inventories/vagrant playbook.yml -e "use_vagrant=true"
```
Or explicitly in the default playbook or default variables of the [k3s-init role](./ansible/roles/k3s-init/README.md):
```bash
cd ansible
# use_vagrant: true in playbook.yml
ansible-playbook -i inventories/vagrant playbook.yml
```

Depending on the operating system of the deploy server, there may be a problem with the public key for authentication to the selected node. Change permissions in the event of a `ssh key is too open` error.
```bash
chmod 0400 ./ansible/[your-key]
```

## More information:
- [Vagrant support](./vagrant/README.md)
- [k3s-init role](./ansible/roles/k3s-init/README.md)
- [k3s-components role](./ansible/roles/k3s-components/README.md)
