# Create a Ravada Server for development

Vagrant by default uses Virtualbox, in our case we use libvirt, and create a KVM machine.

## Create machine
This command creates and configures guest machines according to the Vagrantfile
```bash
$ cd (into your clone directory)
$ vagrant up
```

If you still do not have vagrant, install in your system:
```bash
sudo apt-get install vagrant
```
