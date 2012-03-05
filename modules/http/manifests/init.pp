class http {

    package {
        ["httpd"]:
        ensure => installed;
    }

    file {
        "/etc/httpd/conf.d/html.conf":
        require => Package["httpd"],
        #source => "puppet://$fileserver/http/html.conf",
        content => template("http/html.conf.erb");
    }

#    file {
#        "/tmp/a.tar.gz":
#        source => "puppet://$fileserver/http/abs-guide.html.tar.gz",
#    }
#    exec {
#        "tar xf /tmp/a.tar.gz -C /var/www/html/html":
#        cwd => "/tmp",
#        creates => "/var/www/html/html",
#        path => ["/usr/bin", "/usr/sbin"];
#    }
        

    # Mirror directory
    file {
        "/var/www/html/sample":
        ensure => directory,
        require => Package["httpd"],
        source => "puppet://$fileserver/http/sample",
        ignore => ".svn",
        recurse => true,
        purge => true,
        force => true;
    }

    # delete directory
    #file {
    #    "/var/www/html/html/.svn":
    #    ensure => absent,
    #    force => true;
    #}

    service {
        ["httpd"]:
        require => Package["httpd"],
        subscribe => File["/etc/httpd/conf.d/html.conf"],
        hasrestart => true,
        hasstatus => true,
        ensure => running;
    }

}

