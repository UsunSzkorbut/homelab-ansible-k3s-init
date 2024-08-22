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

### Installing the VMware Utility and Plugin

1. **Install the VMware Utility**:  
   You can install the utility by running the following command:
   ```bash
   vagrant plugin install vagrant-vmware-utility

### Launch environment and destroy it on demand
```bash
vagrant up
vagrant destroy -f
```