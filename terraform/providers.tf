terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://10.0.0.111:8006/api2/json"
    pm_api_token_secret = "2950cc78-bd7f-45de-80c1-9d5833c5e440"
    pm_api_token_id = "root@pam!terraform"
}
