Vagrant Bootstrap
=================

# Why #

Ansible doesn't run on a Windows machine.  In order to use a Windows host for a
Vagrant VM and provision the VM with Ansible, this Vagrantfile will bootstrap
the process by loading a bash script into the VM and run that instead of doing
the provisioning from the host.

This does not require installing Ansible or Cygwin on the Windows machine.  All
you need is Vagrant and an SSH client.  I use the SSH client that comes with
Git on Windows since it is also useful to clone this repo instead of manually
downloading it to the Windows host.

If you're in a similar situation, creating a Linux VM from a Windows host with
Vagrant and you want to use Ansible for provisioning, then maybe this can work
for you.

# Running #

1. Install Vagrant/VirtualBox on Windows machine
2. Install Git (for SSH and github access) on Windows machine
3. `git clone` this repo
4. Run `vagrant up`
5. Verify that everything worked:
```
  (host)$ vagrant ssh
  (vm)$ ls
    vagrant-bootstrap
```

# Some notes #

The idea for this largely comes from this post:
http://lagod.id.au/blog/?p=419

The caveat there is that sharing files between the Windows host and Linux VM is
problematic.  This is not an issue I ran into, but only three files are shared
during the bootstrap process:
```
  bootstrap.sh
  hosts
  site.yml
```

At the moment, they are as simple as an ansible playbook configuration and bash
script could possibly get, so that may be the reason it seems to be working ok.

The bootstrap process should leave you with a local checkout of this project.
Any further actions should probably be done on that copy instead of on the
version shared from the Windows host.

This repo is really just a proof of concept for the model.  If the above issue
becomes problematic, I'd recommend adding the git installation and repo
checkout to the bootstrap script itself with something like this:
```
  apt-get install -y git
  git clone https://github.com/ScorpionResponse/vagrant-bootstrap.git vagrant-bootstrap

```

Put that before the ansible playbook call (final line of bootstrap.sh).  Then
you could run any ansible playbook from that local copy instead of from the
Windows host.

Guessing based on the links from the blog post the problems seem to be related
mostly to actually editing a file or otherwise writing back to the Windows
host.  Hopefully that means the simple, read-only execution of the bootstrap.sh
script would not trigger it.  Otherwise, the only remaining solution would seem
to be inlining the entire bootstrap script in the Vagrantfile:
https://docs.vagrantup.com/v2/provisioning/shell.html#inline-scripts

The final caveat is that all of this assumes you can just `git clone` the
actual code you want to run inside the VM.  If you can do that, then all of
this could be accomplished with just Vagrant and a modified version of this
Vagrantfile on the host in a pinch.  If you can't do that, then check out the
blog post linked above for some other details or suggestions.

# License #

Apache 2
