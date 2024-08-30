k3s-init
=========

An Ansible Role that installs [K3s](https://k3s.io/) server and agents.

Requirements
------------

None.

Role Variables
--------------

Default variables defined as follows:
- `tmp_dir` &mdash; temporary directory path for installation script.
- `k3s` &mdash; set of nested variables for K3s installation such as:
    - `path` &mdash; including paths for installed binary (`bin`), installation script (`install`) and API token (`node_token`).
    - `version` &mdash; release version of Kubernetes.

❗ **NOTE:** Role requires at least one host defined in inventory groups, respectively: `server` and `agents`.

Dependencies
------------

None.

Example Playbook
----------------
    ---
    - name: An example playbook to initialize K3s infrastructure
      hosts: all
      become: true
      vars:
        k3s:
          version: v1.28.13+k3s1
        tmp_dir: /tmp/my_temporary_directory
      roles:
        - k3s-init

License
-------


Author Information
------------------

This role was created in 2024 by:
- [UsunSzkorbut](https://github.com/UsunSzkorbut)
- [kjanxloonix](https://github.com/kjanxloonix)