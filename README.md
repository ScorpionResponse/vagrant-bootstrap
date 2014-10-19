Vagrant Bootstrap
=================

# Why #

Ansible doesn't run on a Windows machine.  In order to use a Windows host for a
Vagrant VM and provision the VM with Ansible, this Vagrantfile will bootstrap
the process by installing Ansible on the VM and run playbooks locally instead
of doing the provisioning from the host.

This does not require installing Ansible or Cygwin on the Windows machine.  All
you need is Vagrant and an SSH client.  I use the SSH client that comes with
Git on Windows since it is also useful to clone this repo instead of manually
downloading it to the Windows host.

If you're in a similar situation, creating a Linux VM from a Windows host with
Vagrant and you want to use Ansible for provisioning, then maybe this can work
for you.

This repo is a proof of concept for the two slightly different models of
isolating Windows from the VM and bootstrapping into a working environment.

# Running #

## Version that mounts CWD from the host to /vagrant on the VM ##
1. Install Vagrant/VirtualBox on Windows machine
2. Install Git (for SSH and github access) on Windows machine
3. `git clone` this repo
4. Run `vagrant up`
5. Verify that everything worked:
```
  (host)$ vagrant ssh
  (vm)$ ls -l
    total 4
    -rw-r--r-- 1 vagrant vagrant    0 Oct 19 13:24 success
    drwxr-xr-x 4 vagrant vagrant 4096 Oct 19 13:24 vagrant-bootstrap
```

## Version that does not share any files from host to VM ##
1. Install Vagrant/VirtualBox on Windows machine
2. Install Git (for SSH and github access) on Windows machine
3. `git clone` this repo
4. Run `NOSHARED='true' vagrant up`
5. Verify that everything worked:
```
  (host)$ vagrant ssh
  (vm)$ ls -l
    total 4
    -rw-r--r-- 1 vagrant vagrant    0 Oct 19 13:24 success
    drwxr-xr-x 4 vagrant vagrant 4096 Oct 19 13:24 vagrant-bootstrap
```

# Some notes #

The idea for this largely comes from this post:
http://lagod.id.au/blog/?p=419

The reason for two different options is that sharing files between the Windows
host and Linux VM is problematic.  This is not an issue I ran into, but with
the first version only three files are shared during the bootstrap process:
```
  ansible/hosts
  ansible/bootstrap.yml
  bootstrap.sh
```

At the moment, they are as simple as an Ansible playbook configuration and bash
script could possibly get, so that may be the reason it seems to be working ok.
If you need to share additional files, read the blog post above for some
warnings.

The bootstrap process should leave you with a local checkout of this project.
Assuming everything worked, the file `success` is created by the local instance
of Ansible running the playbook `ansible/site.yml` from the checkout of the
repo on the VM.  Any further actions should be done on that copy the same way
instead of on the version shared from the Windows host.

Guessing based on the links from the blog post the problems seem to be related
mostly to actually editing a file or otherwise writing back to the Windows
host.  Hopefully that means the simple, read-only execution of the bootstrap.sh
script would not trigger it and therefore you should also be safe to copy over
additional files during the bootstrap process.

A completely isolated solution is also provided in this Vagrantfile.  Instead
of just `vagrant up` run `NOSHARED='true' vagrant up`.  This will not share
anything from the host to the VM and inlines the provisioning script.  The
resulting VM should be exactly the same for this proof of concept.

If you can just `git clone` the actual code you want to run on the VM then the
`NOSHARED='true'` option may be a better choice, since you never have to worry
about Windows/Linux crosstalk except for the running of the actual Vagrantfile,
which I assume works ok.  If you need to copy files from the host into the VM,
then the first option to mount CWD inside the VM might be more useful to you.

Probably you want to edit the Vagrantfile to use only the option that works for
your use case before using this in another project.

# License #

Apache 2
