Vagrant.configure("2") do |config|

  if ARGV[1] == 'noshared'
    ARGV.delete_at(1)
    noshared = true
  else
    noshared = false
  end

  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/1/providers/virtualbox.box"

  if noshared == false
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # avoids 'stdin: is not a tty' error.
    config.vm.provision :shell, path: "bootstrap.sh"
    config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=666']
  else
    $script = <<SCRIPT
sudo apt-get update

# Install Ansible
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

# Install Git
apt-get install -y git

# Checkout the repo
git clone https://github.com/ScorpionResponse/vagrant-bootstrap.git vagrant-bootstrap

# Run Noop for a Proof of concept
cd vagrant-bootstrap
sudo ansible-playbook ansible/site.yml -i ansible/hosts --connection=local

SCRIPT

    config.vm.provision :shell, inline: $script

  end
end
