# homelab-ansible-k3s-init

K3s cluster init with pre-installed components as:
 - Metallb
 - RancherOrchiestrator

## Requirements

| Software   | Version    |
|:----------:|:----------:|
| Proxmox    |            |
| Ansible    |            |
| Terraform  |            |

## Installation
### Run Terraform
> TODO

### Run Ansible playbook
```
cd ansible
ansible-playbook playbook.yml
```

## More information
- [k3s-init role](./ansible/roles/k3s-init/README.md)
