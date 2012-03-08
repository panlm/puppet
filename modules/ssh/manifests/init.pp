class ssh {
    package {
        "openssh-server":
        ensure => installed;
    }
    file {
        "/root/.ssh":
        ensure => directory,
        mode => 700;
    }
    file {
        "/root/.ssh/authorized_keys":
        require => File["/root/.ssh"],
        source => "puppet://$fileserver/ssh/authorized_keys";
    }
    file {
        "/etc/ssh/sshd_config":
        require => Package["openssh-server"],
        source => "puppet://$fileserver/ssh/sshd_config";
    }
    service {
        ["ssh"]:
        require => Package["openssh-server"],
        subscribe => File["/etc/ssh/sshd_config"],
        hasrestart => true,
        hasstatus => true,
        ensure => running;
    }
}

