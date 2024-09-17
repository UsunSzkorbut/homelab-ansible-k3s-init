# Local Infrastructure Setup with Vagrant

This guide describes how to use Vagrant to create a local infrastructure comprising three virtual machines (VMs). The architecture mirrors the deployment setup used in Terraform, including the same IP addresses, and is based on the Ubuntu 22.04 LTS image.

## Prerequisites

To successfully run this setup, ensure that your environment meets the following requirements:

- **Vagrant**: Installed on your local machine.
- **VMware Workstation/VMware Desktop**: Installed and licensed.
- **Vagrant utilities and plugins**: Specified accordingly:

| Name | Description |
| ------ | ----------- |
| `vagrant-vmware-utility` | Utility required by Vagrant to interact with VMware products. |
| `vagrant-vmware-desktop` | Plugin that enables Vagrant to control VMware Workstation/VMware Desktop. |
| `vagrant-timezone` | Plugin that automates time zone configuration for Vagrant VMs. |

### Installing prerequisites

1. Install [Vagrant VMware Utility](https://developer.hashicorp.com/vagrant/install/vmware).

2. Install `vagrant-vmware-desktop` plugin:
   ```bash
   vagrant plugin install vagrant-vmware-desktop
   ```
3. (Optional) Install `vagrant-timezone` plugin:
   ```bash
   vagrant plugin install vagrant-timezone
   ```

### Launch environment and destroy it on demand
Provider should be specified via command parameter.
```bash
vagrant up --provider vmware_desktop
vagrant destroy -f
```
### Alternative configuration (testing purposes)[^1]

[^1]: The following configuration is additional, created for **testing purposes only** and should not be deployed alongside VMWare variant. It deviates from Terraform setup by implementing private networking (host-only), instead of bridged connection to the VMs.

For testing purposes Vagrant infrastructure can be configured with following requirements:

- **Vagrant**: Installed on your local machine.
- **VirtualBox**: Installed on your local machine.
- **Vagrant plugins**: `vagrant-timezone` (optionally).

### ⚠️ IMPORTANT NOTE ⚠️

#### Vagrant private keys
Default private keys for Vagrant boxes may have too open permissions. It can be set manually for each key in `.vagrant` directory:
```bash
chmod 0400 .vagrant/machines/provider/box-name/private_key
```
Or by running predefined script:
```bash
cd homelab-ansible-k3s-init

# Set permissions for executing
chmod 755 ./scripts/set-privkey-perms.sh

# Run the script (read-write permissions for root)
./scripts/set-privkey-perms.sh
```

#### Ansible default Vagrant variables
Default Vagrant directory path and provider are defined in `ansible/group_vars/all.yml` and must be set accordingly.

Variable defining Vagrant usage (`use_vagrant`) must be set accordingly and is specified in files:
 - `ansible/group_vars/all.yml`
 - `ansible/roles/k3s-init/default/all.yml`[^2]

[^2]: Refer to [k3s-init role](../ansible/roles/k3s-init/README.md) documentation.
