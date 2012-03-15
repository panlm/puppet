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
}

# tell puppet on which client to run the class
# this block should be exist, if you want step 11 to success
node default {
    include test_class
}

node vm0 { include base_node_class }
node vm1 {
    include base
    include snmp
    include ssh
    include http
    include sysctl
    include nginx_compile
    include siege
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
node vm21 { include base_node_class }
node vm22 { include base_node_class }
node vm23 { include base_node_class }
node vm24 { include base_node_class }
node vm25 { include base_node_class }
node vm26 { include base_node_class }
node vm27 { include base_node_class }
node vm28 { include base_node_class }
node vm29 { include base_node_class }
node vm30 { include base_node_class }
node vm31 { include base_node_class }
node vm32 { include base_node_class }
node vm33 { include base_node_class }
node vm34 { include base_node_class }
node vm35 { include base_node_class }
node vm36 { include base_node_class }
node vm37 { include base_node_class }
node vm38 { include base_node_class }
node vm39 { include base_node_class }
node vm40 { include base_node_class }
node vm41 { include base_node_class }
node vm42 { include base_node_class }
node vm43 { include base_node_class }
node vm44 { include base_node_class }
node vm45 { include base_node_class }
node vm46 { include base_node_class }
node vm47 { include base_node_class }
node vm48 { include base_node_class }
node vm49 { include base_node_class }
node vm50 { include base_node_class }
node vm51 { include base_node_class }
node vm52 { include base_node_class }
node vm53 { include base_node_class }
node vm54 { include base_node_class }
node vm55 { include base_node_class }
node vm56 { include base_node_class }
node vm57 { include base_node_class }
node vm58 { include base_node_class }
node vm59 { include base_node_class }
node vm60 { include base_node_class }

#import "modules.pp"
