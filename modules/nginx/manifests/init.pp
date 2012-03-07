class nginx {
    package {
        "nginx-release-rhel-5-0.el5.ngx":
        ensure => present,
        provider => rpm,
        source => "http://nginx.org/packages/rhel/5/noarch/RPMS/nginx-release-rhel-5-0.el5.ngx.noarch.rpm";
    }
    package {
        "nginx":
        require => Package["nginx-release-rhel-5-0.el5.ngx"],
        name => "nginx-1.0.12-1.el5.ngx",
        ensure => installed;
    }

    file {
        "/etc/nginx/nginx.conf":
        require => Package["nginx"],
        source => "puppet://$fileserver/nginx/nginx.conf";
    }
    file {
        "/etc/nginx/conf.d/default.conf":
        require => Package["nginx"],
        source => "puppet://$fileserver/nginx/conf.d/default.conf";
    }
    file {
        "/etc/init.d/nginx":
        require => Package["nginx"],
        mode => 755,
        source => "puppet://$fileserver/nginx/init.d/nginx";
    }

    service {
        ["nginx"]:
        require => Package["nginx"],
        subscribe => File["/etc/nginx/nginx.conf","/etc/nginx/conf.d/default.conf","/etc/init.d/nginx"],
        hasrestart => true,
        hasstatus => true,
        ensure => running;
    }

}
