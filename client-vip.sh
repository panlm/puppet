echo "nameserver 172.29.254.100" > /etc/resolv.conf

#rpm -Uhv http://apt.sw.be/redhat/el5/en/i386/rpmforge/RPMS/rpmforge-release-0.3.6-1.el5.rf.i386.rpm
yes y |yum install ruby

mkdir -p /pub/puppet
cd /pub/puppet
wget http://172.29.254.100/facter-1.6.6.tar.gz
wget http://172.29.254.100/puppet-2.6.14.tar.gz
#wget http://puppetlabs.com/downloads/puppet/puppet-2.6.14.tar.gz
#wget http://puppetlabs.com/downloads/facter/facter-1.6.6.tar.gz
tar xf facter-1.6.6.tar.gz
cd facter-1.6.6
ruby install.rb
cd ../
tar xf puppet-2.6.14.tar.gz
cd puppet-2.6.14
ruby install.rb
cd conf/redhat

/bin/cp puppet.conf /etc/puppet/
/bin/cp client.init /etc/init.d/puppet
/bin/cp client.sysconfig /etc/sysconfig/puppet
chmod 755 /etc/init.d/puppet

useradd puppet
mkdir /var/run/puppet
chown -R puppet.puppet /var/run/puppet

echo "send dhcp-client-identifier \"`hostname`\";" > /etc/dhclient-eth0.conf

sed -i "/yinji\.com\.cn/d" /etc/hosts
sed -i "/^search/d" /etc/resolv.conf
echo "    server = vm0" >> /etc/puppet/puppet.conf
puppet agent --test
#service puppet start
chkconfig puppet on

