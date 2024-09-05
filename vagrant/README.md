# Local Infrastructure Setup with Vagrant

This guide describes how to use Vagrant to create a local infrastructure comprising three virtual machines (VMs). The architecture mirrors the deployment setup used in Terraform, including the same IP addresses, and is based on the Ubuntu 22.04 LTS image.

## Prerequisites

To successfully run this setup, ensure that your environment meets the following requirements:

- **Vagrant**: Installed on your local machine.
- **VMware Workstation/VMware Desktop**: Installed and licensed.
- **Vagrant VMware Plugin**: Two specific components need to be installed:

| Plugin | Description |
| ------ | ----------- |
| `vagrant-vmware-utility` | Utility required by Vagrant to interact with VMware products. |
| `vagrant-vmware-desktop` | Plugin that enables Vagrant to control VMware Workstation/VMware Desktop. |

### Alternative configuration (testing purposes)[^1]

[^1]: The following configuration is additional, created for **testing purposes only** and should not be deployed alongside VMWare variant. It deviates from Terraform setup by implementing private networking, instead of bridged connection to the VMs.

For testing purposes Vagrant infrastructure can be configured with following requirements:

- **Vagrant**: Installed on your local machine.
- **VirtualBox**: Installed on your local machine.

Additionally, it is required to install plugin enabling connectivity with VMs configured in private network (host-only configuration):

| Plugin | Description |
| ------ | ----------- |
| `vagrant-hostmanager` | Utility required by Vagrant to enable connectivity to VMs in the private network. |

You can install plugin by running the following command:
```bash
vagrant plugin install vagrant-hostmanager
```

### Installing the VMware Utility and Plugin

[comment]: # (TODO: verify VMWare plugin setup and installation process)

1. **Install the VMware Utility**:  
   You can install the utility by running the following command:
   ```bash
   vagrant plugin install vagrant-vmware-utility
   ```

### Launch environment and destroy it on demand
Provider should be specified via command parameter.
```bash
vagrant up --provider vmware_desktop
vagrant destroy -f
```

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
