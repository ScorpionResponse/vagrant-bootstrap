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

echo -e "[localhost]\nlocalhost\n" > /home/vagrant/hosts
chmod 666 /home/vagrant/hosts
sudo ansible-playbook /vagrant/site.yml -i /home/vagrant/hosts --connection=local
