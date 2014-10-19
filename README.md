Vagrant Bootstrap
=================

# Why #

Ansible doesn't run on a windows machine.  In order to use a windows
host for a Vagrant VM and provision the VM itself with Ansible, this
Vagrantfile will bootstrap the process by loading a bash script into
the VM and run that instead of doing the provisioning itself.

# Running #

1. Install Vagrant/VirtualBox on Windows machine
2. Install Git (for SSH and github access on Windows machine
3. git clone this repo
4. Run `vagrant up`
5. Verify that everything worked
```
  (host)$ vagrant ssh
  (vm)$ ls
    hosts  vagrant-bootstrap
```

# License #

Apache 2
