# Create "/tmp/testfile" if it doesn't exist.
class test_class {
    file { "/tmp/testfile":
       ensure => present,
       mode   => 600,
       owner  => root,
       group  => root
    }
}

$fileserver = "testvm-0"

class basepackage {
    package {
        ["sysstat"]:
        ensure => installed;
        ["NetworkManager", "bluez-*"]:
        ensure => purged;
    }
    service {
        ["ssh"]:
        ensure => running;
        ["snmpd"]:
        ensure => running;
        ["sendmail"]:
        ensure => stopped;
    }
}

# tell puppet on which client to run the class
# this block should be exist, if you want step 11 to success
node testvm-1 {
    include basepackage
    include html1
}
node testvm-2 {
    include basepackage
}
node testvm-3 {
    include basepackage
}
node testvm-4 {
    include basepackage
}
node testvm-5 {
    include basepackage
}
node default {
    include test_class
}

import "modules.pp"
#import "nodes/*.pp"

