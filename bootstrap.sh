#!/usr/bin/env bash

# Bootstrap the Vagrant VM by installing Ansible
# and let Ansible handle the rest.

# Make sure we're up to date
sudo apt-get update

# Install Ansible
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

# Run playbook to provision up VM
# This just installs git and checks out this repo
sudo ansible-playbook /vagrant/ansible/bootstrap.yml -i /vagrant/ansible/hosts --connection=local

# Run Noop for a Proof of concept
cd vagrant-bootstrap
sudo ansible-playbook ansible/site.yml -i ansible/hosts --connection=local
