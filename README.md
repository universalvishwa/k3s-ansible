# Build a Kubernetes cluster using k3s via Ansible

[![Kubernetes](https://img.shields.io/badge/kubernetes-1.20-326CE5?logo=kubernetes)](https://rancher.com/) [![License: Apache](https://img.shields.io/badge/License-Apache-yellow.svg)](https://github.com/universalvishwa/k3s-ansible/blob/master/LICENSE) [![Python](https://img.shields.io/badge/python-3.7-blue?logo=python)](https://www.python.org/downloads/release/python-379/) [![Ansible](https://img.shields.io/badge/ansible-3.1-EE0000?logo=ansible)](https://docs.ansible.com/) [![Molecule](https://img.shields.io/badge/molecule-v3.2-3CAFCE)](https://molecule.readthedocs.io/)

Forked from [k3s-ansible](https://github.com/k3s-io/k3s-ansible)
Author: <https://github.com/itwars>


<details><summary>Read me from the official repository</summary>

## K3s Ansible Playbook

Build a Kubernetes cluster using Ansible with k3s. The goal is easily install a Kubernetes cluster on machines running:

- [X] Debian
- [X] Ubuntu
- [X] CentOS

on processor architecture:

- [X] x64
- [X] arm64
- [X] armhf

## System requirements

Deployment environment must have Ansible 2.4.0+
Master and nodes must have passwordless SSH access

## Usage

First create a new directory based on the `sample` directory within the `inventory` directory:

```bash
cp -R inventory/sample inventory/my-cluster
```

Second, edit `inventory/my-cluster/hosts.ini` to match the system information gathered above. For example:

```bash
[master]
192.16.35.12

[node]
192.16.35.[10:11]

[k3s_cluster:children]
master
node
```

If needed, you can also edit `inventory/my-cluster/group_vars/all.yml` to match your environment.

Start provisioning of the cluster using the following command:

```bash
ansible-playbook site.yml -i inventory/my-cluster/hosts.ini
```

## Kubeconfig

To get access to your **Kubernetes** cluster just

```bash
scp debian@master_ip:~/.kube/config ~/.kube/config
```
</details>

## Overview
- Ansible playbook installs Kubernetes (k3s) on a Raspberry Pi 3/4 primarily.
    - Also support other hardware architectures (`x86`, `Arm`).
- The OS running in Raspberry Pi can be `Raspberry Pi OS` or `Ubuntu 20.04`.
- _**[K3S](https://k3s.io/)**_ is a CNCF certified _Lightweight Kubernetes_ distribution built for IoT & Edge computing and supports _ARM_ CPU architectures.
- This repository is forked from the official K3s Ansible playbook managed by _Rancher_.
- This work is done as part of a Hobby project on setting up an IoT Stack in a Home network.
- The playbooks are configured to use _SSH Keys_ instead of username/password to connect to Raspberry Pi.
    - ???`hosts_example.ini` shows an example hosts file used for Ansible playbooks.

### Notes:
- Global variables file `group_vars/all.yml` is updated to be more permanent/static.
    - If `k3s_version` is not defined, the playbook will automatically install the latest k3s version.
    - Set the `k3s_version` to install a specific k3s version.
    - Set the `ansible_user` variable if different that current ansible server.
- When adding new _**Worker nodes**_ to the cluster, add the new host to the `[node]` ansible group in `hosts.ini` file and re-run the playbook.

#### Setup environment
- Pre-requisites:
    - Add the SSH public key `id_rsa.pub` to `/home/pi/.ssh/authorized_keys` in all Raspberry Pi servers.
- Required tools/utilities:
    - Python 3.7+
    - Ansible 3.0+
    - git
- Install the Python packages in `requirements.txt` before running Ansible commands. These packages/utilities are needed for auxiliary tasks like molecule testing, linting etc.
    ```bash
    $ pip3 install -r requirements.txt
    ```
- Update the Fork from [k3s-ansible](https://github.com/k3s-io/k3s-ansible) playbook.
    ```bash
    $ make update-fork
    ```
- Update global variables in `group_vars/all.yml` to match the environment if needed.


## Run Ansible playbooks
1. Run Ansible ping to test connectivity.
    ```bash
    $ ansible-playbook -i hosts.ini ansible_ping.yml
    ```
2. Install and configure Kubernetes (k3s).
    ```bash
    $ ansible-playbook -i hosts.ini site.yml
    ```
3. Add Kubernetes cluster context to Kubeconfig file.
    ```bash
    $ scp ubuntu@master:~/.kube/config ~/.kube/config
    ```
4. Verify access to cluster
    ```bash
    $ kubectl get nodes
    $ kubectl get nodes --context default
    ```
5. Unconfigure and uninstall Kubernetes (k3s).
    ```bash
    $ ansible-playbook -i hosts.ini reset.yml

## References
- [Build a Kubernetes cluster using k3s via Ansible](https://github.com/k3s-io/k3s-ansible)
- [Lightweight Kubernetes (k3s)](https://k3s.io/)
- [Raspberry Pi Cluster Episode 3 - Installing K3s Kubernetes on the Turing Pi](https://www.jeffgeerling.com/blog/2020/installing-k3s-kubernetes-on-turing-pi-raspberry-pi-cluster-episode-3)
- [How to merge Kubernetes kubeconfig files](https://jacobtomlinson.dev/posts/2019/how-to-merge-kubernetes-kubectl-config-files/)
- [Ansible Role: k3s (v2.x)](https://github.com/PyratLabs/ansible-role-k3s)