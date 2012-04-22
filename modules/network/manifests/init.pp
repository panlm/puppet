class network {
    if $ipaddress =~ /172\.29/ {
        file {
            "/etc/sysconfig/network-scripts/ifcfg-eth0":
            content => template("network/ifcfg-eth0.erb"),
            alias => ifcfg-eth0;
        }
    } else {
        file {
            "/etc/sysconfig/network-scripts/ifcfg-eth0":
            content => template("network/ifcfg-eth0-dhcp.erb"),
            alias => ifcfg-eth0;
        }
    }
    service {
        ["network"]:
        subscribe => File["ifcfg-eth0"],
        hasrestart => true,
        hasstatus => true,
        ensure => running;
    }
}

