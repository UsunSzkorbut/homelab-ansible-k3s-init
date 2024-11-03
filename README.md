# terraform-ansible-k3s-cluster

K3s cluster init with pre-installed components as:
 - **Metallb**
 - **Helm support** / Available only on Deployer node
 - **Cert-Manager**
 - **Nginx Ingress Controller** / Traefik disabled
 - **External-DNS for PiHole** / Not being installed by default
 - **Longhorn** / Custom resources
 - **RancherOrchiestrator** / Not being installed by default

## TODO:
#### Ansible
- [ ] Update README
- [ ] Clean and rename tags
- [ ] Update Vagrant tasks

## Environment specification

✅ **Test Environment:** All components have been successfully tested on the cloud base image of **Ubuntu Server 22.04 LTS**, All tasks are performed on debian derivatives - repo update, apt install, etc.

❗ All tasks are performed on **Debian derivatives** - repo update, apt install, etc.

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

## Recommended Cluster Topology 
| Role       | Specification    | Hostname        |IP               |
|:-----------|:-----------------|:---------------:|:---------------:|
| master     | Workload ready   | k3s-master-01 [K3S Deployer]  |     10.0.0.11   |
| master     | Workload ready   | k3s-master-02   |     10.0.0.12   |
| master     | Workload ready   | k3s-worker-01   |     10.0.0.21   |
| agent      | Workload ready   | k3s-worker-02   |     10.0.0.22   |

To balance high availability with limited resources, a 4-node cluster was set up, consisting of 3 master nodes and 1 worker nodes.

When installing a cluster using --cluster-init, ETCD is used instead of standard SQLite. The number of nodes supporting ETCD must be odd. In this case, to preserve the HA behavior of the cluster, the minimum number of control-nodes must be 3. This architecture ensures redundancy while maximizing resource efficiency.

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
#### Proxmox hosts / Custom Provider
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
