k3s-components
=========

An Ansible Role that installs and initializes components:
- Helm
- Metallb
- Cert-Manager
- Nginx-Ingress Controller
- ExternalDNS
- Rancher
- Longhorn

Requirements
------------

- [K3s](https://k3s.io/) installed on all hosts.

Role Variables
--------------

Default variables defined as follows:
- `tmp_dir` &mdash; temporary directory path for installation scripts.
- `helm` &mdash; set of nested variables for Helm (e.g. path to installation script).
- `install_longhorn` &mdash; variable specifying installation of Longhorn (*true* by default).
- `install_externaldns` &mdash; variable specifying installation of ExternalDNS (*false* by default).
- `install_rancher` &mdash; variable specifying installation of Rancher (*false* by default).
- `metallb` &mdash; set of nested variables for Metallb (e.g. `namespace`).
- `cert_manager` &mdash; set of nested variables for Cert-Manager.
- `nginxingresscontroller` &mdash; set of nested variables for Nginx-Ingress controller.
- `externaldns` &mdash; set of nested variables for ExternalDNS.
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
