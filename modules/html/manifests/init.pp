class html1 {
    package {
        "httpd":
        ensure => installed;
    }
    file {
        "/etc/httpd/conf.d/html.conf":
        require => Package["httpd"],
        source => "puppet://$fileserver/html/html.conf";
    }
    file {
        "/var/www/html/html1":
        require => Package["httpd"],
        source => "puppet://$fileserver/html/abs-guide",
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

class html2 {
    package {
        "httpd":
        ensure => installed;
    }
    file {
        "/etc/httpd/conf.d/html.conf":
        require => Package["httpd"],
        source => "puppet://$fileserver/html/html.conf";
    }
    file {
        "/var/www/html/html1":
        ensure => directory,
        force => true,
        require => Package["httpd"],
        source => "puppet://$fileserver/html/Mobile-Guide",
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

class html3 {
    package {
        "httpd":
        ensure => installed;
    }
    file {
        "/etc/httpd/conf.d/html.conf":
        require => Package["httpd"],
        source => "puppet://$fileserver/html/html.conf";
    }
    file {
        "/var/www/html/html1":
        ensure => directory,
        force => true,
        require => Package["httpd"],
        source => "puppet://$fileserver/html/win",
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
