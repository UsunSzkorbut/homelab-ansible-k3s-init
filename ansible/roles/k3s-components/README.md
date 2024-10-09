k3s-components
=========

An Ansible Role that installs and initializes components:
- Metallb
- Helm
- Cert-Manager
- Nginx-Ingress Controller
- RancherOrchiestrator
- Longhorn

Requirements
------------

- [K3s](https://k3s.io/) installed on all hosts.

Role Variables
--------------

Default variables defined as follows:
- `tmp_dir` &mdash; temporary directory path for installation scripts.
- `kube_dir_path` &mdash; path to K3s configuration directory.
- `cluster_ns` &mdash; set of variables for cluster namespaces.
- `k3s.path.conf_src` &mdash; path to `k3s.yaml` file.
- `metallb` &mdash; set of nested variables for Metallb (e.g. `version`).
- `helm.path.bin` &mdash; path to installed Helm binary.
- `cert_manager` &mdash; set of nested variables for Cert-Manager.
- `nginx_ingress_controller` &mdash; set of nested variables for Nginx-Ingress controller.
- `rancher` &mdash; set of nested variables for Rancher.
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

GPL-3.0

Author Information
------------------

This role was created in 2024 by:
- [UsunSzkorbut](https://github.com/UsunSzkorbut)
- [kjanxloonix](https://github.com/kjanxloonix)
