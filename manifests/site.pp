# Create "/tmp/testfile" if it doesn't exist.
class test_class {
    file { "/tmp/testfile":
       ensure => present,
       mode   => 644,
       owner  => root,
       group  => root
    }
}

$fileserver = "vm0"

class base_node_class {
    include base
    include snmp
    include ssh
    include http
    include sysctl
    include nginx_compile
    include siege
    include ntp
    include network
}

# tell puppet on which client to run the class
# this block should be exist, if you want step 11 to success
node default {
    include test_class
}

node vm115 {
    include base
    include snmp
    include ssh
    include http
    include sysctl
    include nginx_compile
    include siege
    include ntp
    include network
}

node vm0 { include base_node_class }
node /^vm3$/ inherits vm0 {}
node /^vm[4-9]$/ inherits vm0 {}
node /^vm[0-9][0-9]+$/ inherits vm0 {}

# or
#case $hostname {
#    /^vm[3-9]$/: { include base_node_class }
#    /^vm[0-9][0-9]+$/: { include base_node_class }
#    default:    { include test_class }
#}

#import "modules.pp"

