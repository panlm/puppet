class ssh {
    file {
        "/root/.ssh":
        ensure => directory,
        mode => 700,
        alias => ".ssh";
    }
    file {
        "/root/.ssh/authorized_keys":
        require => File[".ssh"],
        source => "puppet://$fileserver/ssh/authorized_keys";
    }
    file {
        "/etc/ssh/sshd_config":
        source => "puppet://$fileserver/ssh/sshd_config",
        mode => 600,
        alias => "sshd_config";
    }
    service {
        ["sshd"]:
        subscribe => File["sshd_config"],
        hasrestart => true,
        hasstatus => true,
        ensure => running;
    }
}

