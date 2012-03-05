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

class basepackage {
    package {
        ["NetworkManager", "bluez-*"]:
        ensure => purged;
    }
}

class base_node_class {
    include basepackage
    include snmp
    include ssh
    include http
    include sysctl
}

# tell puppet on which client to run the class
# this block should be exist, if you want step 11 to success
node default {
    include test_class
}

node vm1 {
    include basepackage
    include snmp
    include ssh
    include http
    include sysctl
}
node vm2 {
    include base_node_class
}
node vm3 {
    include base_node_class
}
node vm4 {
    include base_node_class
}

#import "modules.pp"
