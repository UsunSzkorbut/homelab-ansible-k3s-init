#!/bin/bash

# Set Vagrant environment path
vagrant_path="./vagrant/.vagrant"

# Change permissions for private_key files
sudo chmod 600 $vagrant_path/machines/*/*/private_key

# Show permissions for private_key files
ls -l $vagrant_path/machines/*/*/private_key