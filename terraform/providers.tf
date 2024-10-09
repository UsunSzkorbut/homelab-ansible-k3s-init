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
    pm_api_url = "https://X.X.X.X:8006/api2/json"
    pm_api_token_secret = "<YOUR_API_KEY>"
    pm_api_token_id = "root@pam!terraform"
}
