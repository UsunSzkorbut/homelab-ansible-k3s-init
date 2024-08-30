k3s-components
=========

An Ansible Role that installs and initializes components:
- Metallb
- Helm
- Cert-Manager
- RancherOrchiestrator
- Longhorn

Requirements
------------

- [K3s](https://k3s.io/) installed on all hosts.

Role Variables
--------------

Default variables defined as follows:
- `tmp_dir` &mdash; temporary directory path for installation script.
- `kube_dir_path` &mdash; path for `kube.conf`.
- `cluster_ns` &mdash; set of variables for cluster namespaces.
- `k3s.path.conf_src` &mdash; set of nested variables for K3s.
- `metallb` &mdash; set of nested variables for Metallb.
- `cert_manager` &mdash; set of nested variables for Cert-Manager.
- `rancher` &mdash; &mdash; set of nested variables for Rancher.
- `longhorn` &mdash; set of nested variables for Longhorn.

Dependencies
------------

- [kubernetes.core](https://github.com/ansible-collections/kubernetes.core)

❗ **NOTE:** Role can be used supplementarily with [k3s-init](../k3s-init/README.md) role.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - name: An example playbook to initialize K3s components
      hosts: localhost
      become: true
      vars:
        metallb:
          pool_name: example-name
        rancher:
          bootstrapPassword: admin
      roles:
        - k3s-components

License
-------


Author Information
------------------

This role was created in 2024 by:
- [UsunSzkorbut](https://github.com/UsunSzkorbut)
- [kjanxloonix](https://github.com/kjanxloonix)
