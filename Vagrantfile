  Vagrant.configure(2) do |config|
  config.vm.box = "sjohnsen/ubuntu1804"
  config.vm.network "private_network", ip: "192.168.121.10"
  config.vm.hostname = "ravadaDevel"
  config.vm.provider "libvirt" do |vb|
     vb.memory = "2048"
  end

config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end


  config.vm.provision "file", source: "ravada.conf", destination: "ravada.conf"
  config.vm.provision "file", source: "start_ravada.sh", destination: "start_ravada.sh"

  config.vm.provision "shell", inline: <<-SHELL

# Disable IPv6 in the host, often we dont need to have IPv6 support.
	sudo apt-get update
	sudo apt-get install git
	sudo cp ravada.conf /etc
	mkdir src
	cd src
	sudo git clone https://github.com/UPC/ravada.git
	sudo chown -R vagrant:vagrant ravada
	sudo su
	echo  "Disabling IPv6"
	echo "net.ipv6.conf.all.disable_ipv6 = 1
      net.ipv6.conf.default.disable_ipv6 = 1
      net.ipv6.conf.lo.disable_ipv6 = 1
      net.ipv6.conf.eth0.disable_ipv6 = 1" >> /etc/sysctl.conf
	sysctl -p
	sudo sed -ie '/^XKBLAYOUT=/s/".*"/"es"/' /etc/default/keyboard && udevadm trigger --subsystem-match=input --action=change

# Set mysql admin passwd
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password s3cret'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password s3cret'
	sudo apt-get install -y mysql-server libmojolicious-plugin-renderfile-perl
	sudo apt-get install -y perl libmojolicious-perl mysql-common libauthen-passphrase-perl \
	libdbd-mysql-perl libdbi-perl libdbix-connector-perl libipc-run3-perl libnet-ldap-perl \
	libproc-pid-file-perl libvirt-bin libsys-virt-perl libxml-libxml-perl libconfig-yaml-perl \
	libmoose-perl libjson-xs-perl qemu-utils perlmagick libmoosex-types-netaddr-ip-perl \
	libsys-statistics-linux-perl libio-interface-perl libiptables-chainmgr-perl libnet-dns-perl \
	wget liblocale-maketext-lexicon-perl libmojolicious-plugin-i18n-perl libdbd-sqlite3-perl \
	debconf adduser libdigest-sha-perl qemu-kvm libnet-ssh2-perl libfile-rsync-perl \
	libdate-calc-perl libparallel-forkmanager-perl libproc-pid-file-perl libdbix-connector-perl \
	libdatetime-perl

# Create ravada DB and grants
	sudo mysqladmin processlist -u root -ps3cret create ravada
	sudo mysql -u root -ps3cret ravada -e "grant all on ravada.* to rvd_user@'localhost' identified by 'changeme'"

# Bye
	sudo sh -c 'echo "###    ##   #  #   ##   ###    ##         #  #  ###   ###   " > /etc/motd'
	sudo sh -c 'echo "#  #  #  #  #  #  #  #  #  #  #  #        #  #  #  #   #    " >> /etc/motd'
	sudo sh -c 'echo "#  #  #  #  #  #  #  #  #  #  #  #        #  #  #  #   #    " >> /etc/motd'
	sudo sh -c 'echo "###   ####  #  #  ####  #  #  ####        #  #  #  #   #    " >> /etc/motd'
	sudo sh -c 'echo "# #   #  #   ##   #  #  #  #  #  #         ##   #  #   #    " >> /etc/motd'
	sudo sh -c 'echo "#  #  #  #   ##   #  #  ###   #  #         ##   ###   ### \n" >> /etc/motd'
	sudo sh -c 'echo "More information https://github.com/UPC/ravada" >> /etc/motd'
	sudo sh -c 'echo "Two steps to finish:" >> /etc/motd'
	sudo sh -c 'echo "Create ravada admin user" >> /etc/motd'
	sudo sh -c 'echo "Execute:   $ sudo ./bin/rvd_back.pl --add-user user.name" >> /etc/motd'
	sudo sh -c 'echo "and" >> /etc/motd'
	sudo sh -c 'echo "./start_ravada.sh" >> /etc/motd'
	sudo sh -c 'echo "For shutdown: ./shutdown_ravada.sh" >> /etc/motd'
	sudo sh -c 'echo "Now you must be able to reach ravada at the location http://your.ip:3000/" >> /etc/motd'

  SHELL
end
