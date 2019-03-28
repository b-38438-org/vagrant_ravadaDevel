# Local requirements
- KVM & libvirt 
- vagrant

# Create a Ravada Server for development

Vagrant by default uses Virtualbox, in our case we use libvirt, and create a KVM machine.

If you still do not have vagrant, install in your system:
```bash
sudo apt-get install vagrant
```

## First Step
- Clone this repository
```
$ git clone https://github.com/fv3rdugo/vagrant_ravadaDevel.git
$ cd vagrant_ravadaDevel/
```

## Create machine
```
$ vagrant up
```

## Access to VM
Login & password by default: vagrant / vagrant
Create an admin account:
```
$ sudo src/ravada/bin/rvd_back.pl --add-user user.name
$ ./start_ravada.sh

```
Now you must be able to reach ravada at the location http://your.ip:3000/ or http://192.168.121.10:3000

Enjoy!
