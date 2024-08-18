# homelab-ansible-k3s-init

K3s cluster init with pre-installed components as:
 - Metallb
 - Cert-Manager
 - RancherOrchiestrator

## Environment specification

✅ **Test Environment:** All components have been successfully tested on the cloud base image of **Ubuntu Server 22.04 LTS**.

✅ **Deployment Server:** The deployment server has been configured using **WSL 2** with **Ubuntu 22.04 LTS** as the operating system.

❗ **Terraform & Proxmox:** When using Terraform in conjunction with Proxmox, it is required to create a cloud-init from the Proxmox interface, following the documentation [Click here](https://pve.proxmox.com/wiki/Cloud-Init_Support).

## Software requirements

| Software   | Version    |
|:----------:|:----------:|
| Proxmox    |     8      |
| Ansible    |     Core 2.16.10       |
| Terraform  |     v1.9.4       |

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

### Run Ansible playbook
```bash
cd ansible
ansible-playbook playbook.yml
```
Depending on the operating system of the deploy server, there may be a problem with the public key for authentication to the selected node. Change permissions in the event of a `ssh key is too open` error.
```bash
chmod 0400 ./ansible/[your-key]
```

## More information
- [k3s-init role](./ansible/roles/k3s-init/README.md)
