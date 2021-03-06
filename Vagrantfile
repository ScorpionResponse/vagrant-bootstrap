# -*- mode: ruby -*-
# vi: set ft=ruby :

# Invoke this with either
# vagrant up
# or
# NOSHARED='true' vagrant up

if ENV['NOSHARED'] == 'true'
  noshared = true
else
  noshared = false
end

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/1/providers/virtualbox.box"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # avoids 'stdin: is not a tty' error.

  if noshared == false
    # Mount the current working directory
    # and execute the bootstrap script which calls the Ansible bootstrap process

    config.vm.provision :shell, path: "bootstrap.sh"
    config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=666']

  else
    # Mount nothing and run this heredoc inline

    $script = <<SCRIPT
apt-get update

# Install Ansible
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible

# Install Git
apt-get install -y git

# Checkout the repo
sudo -i -u vagrant git clone https://github.com/ScorpionResponse/vagrant-bootstrap.git vagrant-bootstrap

# Run Noop for a Proof of concept
cd vagrant-bootstrap
ansible-playbook ansible/site.yml -i ansible/hosts --connection=local

SCRIPT

    config.vm.provision :shell, inline: $script

  end
end
