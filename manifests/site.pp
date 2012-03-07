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
        ["siege"]:
        ensure => installed;
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
    include nginx
}

# tell puppet on which client to run the class
# this block should be exist, if you want step 11 to success
node default {
    include test_class
}

node vm0 { include base_node_class }
node vm1 {
    include basepackage
    include snmp
    include ssh
    include http
    include sysctl
    include nginx
}
node vm2 { include base_node_class }
node vm3 { include base_node_class }
node vm4 { include base_node_class }
node vm5 { include base_node_class }
node vm6 { include base_node_class }
node vm7 { include base_node_class }
node vm8 { include base_node_class }
node vm9 { include base_node_class }
node vm10 { include base_node_class }
node vm11 { include base_node_class }
node vm12 { include base_node_class }
node vm13 { include base_node_class }
node vm14 { include base_node_class }
node vm15 { include base_node_class }
node vm16 { include base_node_class }
node vm17 { include base_node_class }
node vm18 { include base_node_class }
node vm19 { include base_node_class }
node vm20 { include base_node_class }

#import "modules.pp"
