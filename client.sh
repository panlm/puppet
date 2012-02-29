rpm -Uhv http://apt.sw.be/redhat/el5/en/i386/rpmforge/RPMS/rpmforge-release-0.3.6-1.el5.rf.i386.rpm
yes y |yum install ruby

mkdir -p /pub/puppet
cd /pub/puppet
wget http://172.29.255.199/facter-1.6.6.tar.gz
wget http://172.29.255.199/puppet-2.6.14.tar.gz
tar xf facter-1.6.6.tar.gz
cd facter-1.6.6
ruby install.rb
cd ../
tar xf puppet-2.6.14.tar.gz
cd puppet-2.6.14
ruby install.rb
cd conf/redhat

cp puppet.conf /etc/puppet/
cp client.init /etc/init.d/puppet
cp client.sysconfig /etc/sysconfig/puppet
chmod 755 /etc/init.d/puppet

useradd puppet
mkdir /var/run/puppet
chown -R puppet.puppet /var/run/puppet

echo "send dhcp-client-identifier \"`hostname`\";" > /etc/dhclient-eth0.conf

sed -i "/^yinji\.com\.cn/d" /etc/hosts
sed -i "/^search/d" /etc/resolv.conf
echo "    server = testvm-0" >> /etc/puppet/puppet.conf
puppet agent --test
