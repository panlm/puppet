class sysctl {
    file {
        "/etc/security/limits.conf":
        source => "puppet://$fileserver/sysctl/limits.conf";
    }
    file {
        "/etc/sysctl.conf":
        source => "puppet://$fileserver/sysctl/sysctl.conf";
    }
    exec {
        "/sbin/sysctl -p /etc/sysctl.conf":
        path => ["/usr/bin", "/usr/sbin"],
        subscribe => File["/etc/sysctl.conf"],
        refreshonly => true;
    }
}

