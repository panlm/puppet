class http {
    package {
        ["httpd"]:
        ensure => installed;
    }
    file {
        "/etc/httpd/conf.d/html.conf":
        require => Package["httpd"],
        source => "puppet://$fileserver/http/html.conf";
    }
    file {
        "/var/www/html/html":
        ensure => directory,
        require => Package["httpd"],
        source => "puppet://$fileserver/http/sample",
        recurse => true;
    }
    service {
        ["httpd"]:
        require => Package["httpd"],
        subscribe => File["/etc/httpd/conf.d/html.conf"],
        hasrestart => true,
        hasstatus => true,
        ensure => running;
    }
}

