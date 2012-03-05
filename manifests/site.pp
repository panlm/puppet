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
}
node vm4 {
    include basepackage
    include snmp
    include ssh
}
