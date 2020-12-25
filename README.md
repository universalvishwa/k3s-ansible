# Install Kubernetes (k3s) in Raspberry Pi with Ansible

[![Kubernetes](https://img.shields.io/badge/kubernetes-1.20.0-326CE5?logo=kubernetes)](https://rancher.com/) [![License: Apache](https://img.shields.io/badge/License-Apache-yellow.svg)](https://github.com/universalvishwa/k3s-ansible/blob/master/LICENSE) [![Python](https://img.shields.io/badge/python-3.7-blue?logo=python)](https://www.python.org/downloads/release/python-379/) [![Ansible](https://img.shields.io/badge/ansible-2.10-EE0000?logo=ansible)](https://docs.ansible.com/) [![Molecule](https://img.shields.io/badge/molecule-v3.2-3CAFCE)](https://molecule.readthedocs.io/)

Forked from [k3s-ansible](https://github.com/k3s-io/k3s-ansible)

## Overview
- Ansible playbook installs Kubernetes (k3s) on a Raspberry Pi 3/4.
- The OS running in Raspberry Pi can be `Raspberry Pi OS` or `Ubuntu 20`.
- _**[K3S](https://k3s.io/)**_ is a CNCF certified _Lightweight Kubernetes_ distribution built for IoT & Edge computing and supports _ARM_ CPU architectures.
- The repository is forked from the official K3S Ansible playbook managed by _Rancher_.
- This work is done as part of a Hobby project on setting up an IoT Stack in a Home network.
- The playbooks are configured to use _SSH Keys_ instead of username/password to connect to Raspberry Pi.
    - `hosts_example.ini` shows an example hosts file used for Ansible playbooks.

### Notes:
- Global variables file `group_vars/all.yml` is updated to be more permanent/static.
    - Updated with latest stable k3s release: `v1.19.5+k3s2`
    - `ansible_user` variable will be set in the `hosts.ini`.
- Run the _playbpook.yml_ Ansible playbook (derived) instead of _site.yml_. 

## Run Ansible playbooks
1. Run Ansible ping to test connectivity to Raspberry Pi.
    ```bash
    $ ansible-playbook -i hosts.ini ansible_ping.yml -l rpi
    ```
2. Install and configure Kubernetes (k3s) on Raspberry Pi.
    ```bash
    $ ansible-playbook -i hosts.ini playbook.yml
    ```

#### Setup Ansible environment
- Pre-requisites:
    - Add the SSH public key `id_rsa.pub` to `/home/pi/.ssh/authorized_keys` in Raspberry Pi.
- Pre-requisites:
    - Python 3.7+
    - Python-pip
    - git
- Install the Python packages in `requirements.txt` before running Ansible commands.
    ```bash
    $ pip3 install -r requirements.txt
    ```

## References
- [Build a Kubernetes cluster using k3s via Ansible](https://github.com/k3s-io/k3s-ansible)
- [Lightweight Kubernetes (k3s)](https://k3s.io/)
- [Raspberry Pi Cluster Episode 3 - Installing K3s Kubernetes on the Turing Pi](https://www.jeffgeerling.com/blog/2020/installing-k3s-kubernetes-on-turing-pi-raspberry-pi-cluster-episode-3)
- [Syncing a fork](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/syncing-a-fork)
