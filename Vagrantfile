Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/1/providers/virtualbox.box"
  #config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # avoids 'stdin: is not a tty' error.
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=666']
end
