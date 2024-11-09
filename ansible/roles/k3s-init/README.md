k3s-init
=========

An Ansible Role that installs [K3s](https://k3s.io/) server and agents.

Requirements
------------

None.

Role Variables
--------------

Default variables defined as follows:
- `use_vagrant` &mdash; variable specifying usage of Vagrant (*false* by default).
- `tmp_dir` &mdash; temporary directory path for installation script.
- `k3s` &mdash; set of nested variables for K3s installation such as:
    - `path` &mdash; including paths for installed binary, installation script, API token and uninstallation scripts.
    - `version` &mdash; release version of Kubernetes.
- `k3s_kube_conf` &mdash; set of variables related to Kube config paths.

❗ **NOTE:** Role requires at least one host defined in inventory groups, respectively: `deployer`, `servers` and `agents`.

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

GPL-3.0

Author Information
------------------

This role was created in 2024 by:
- [UsunSzkorbut](https://github.com/UsunSzkorbut)
- [kjanxloonix](https://github.com/kjanxloonix)