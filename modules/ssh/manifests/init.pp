class ssh {
    service {
        ["ssh"]:
        ensure => running;
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
}

