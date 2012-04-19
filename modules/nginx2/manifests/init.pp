class remove_nginx_rpm {
    package {
        "nginx-release-rhel-5-0.el5.ngx":
        ensure => absent;
        "nginx":
        name => "nginx-1.0.12-1.el5.ngx",
        ensure => purged;
    }

    $userlist = [ "nginx" ]
#    $grouplist = [ "nginx" ]
    user {
        $userlist:
        ensure => absent;
    }
#    group {
#        $grouplist:
#        ensure => absent;
#    }
}

class nginx2 {
    include remove_nginx_rpm
    package {
        ["pcre", "pcre-devel"]:
        ensure => installed;
    }
    exec {
        "dir1":
        require => [Class["remove_nginx_rpm"],Package["pcre", "pcre-devel"]],
        path => "/usr/bin:/usr/sbin:/bin",
        command => "mkdir -p /pub/nginx ",
        creates => "/pub/nginx";
    }

    file {
        "/pub/nginx/nginx-1.0.13.tar.gz":
        require => Exec["dir1"],
        source => "puppet://$fileserver/nginx2/nginx-1.0.13.tar.gz",
        alias => "tarball";
    }

exec { "build":
cwd => "/pub/nginx/",
require => File[tarball],
command => "/bin/tar xf nginx-1.0.13.tar.gz &&
cd nginx-1.0.13 && ./configure --prefix=/usr/local/nginx --with-http_ssl_module && make && make install",
creates => "/usr/local/nginx/sbin/nginx",
logoutput => on_failure,
timeout => 0,
}

    exec {
        "untar":
        require => File[tarball],
        path => "/usr/bin:/usr/sbin:/bin",
        command => "tar xf nginx-1.0.13.tar.gz",
        cwd => "/pub/nginx",
        creates => "/pub/nginx/nginx-1.0.13";
    }
    exec {
        "compile":
        require => Exec["untar"],
        path => "/usr/bin:/usr/sbin:/bin",
        command => "/pub/nginx/nginx-1.0.13/configure --prefix=/usr/local/nginx --with-http_ssl_module --add-module=../gnosek-nginx-upstream-fair-5f6a3b7/ && make && make install",
        cwd => "/pub/nginx/nginx-1.0.13",
        creates => "/usr/local/nginx";
    }

    file {
        "/usr/local/nginx/conf/nginx.conf":
        require => Exec["build"],
        #source => "puppet://$fileserver/nginx_compile/nginx/conf/nginx.conf";
        content => template("nginx_compile/nginx.conf.erb"),
        alias => "nginx.conf";
        "/etc/init.d/nginx":
        require => Exec["compile"],
        source => "puppet://$fileserver/nginx_compile/init/nginx";
    }

    cron {
        empty_error_log:
        ensure  => present,
        command => "/bin/cp /dev/null /usr/local/nginx/logs/error.log",
        user => root,
        minute => '0',
        hour => '0';
    }

#    if $hostname =~ /^(vm[2-9]|vm[123][0-9])$/ {
    if $ipaddress =~ /^(172\.29\.249\.[2-9]|172\.29\.249\.[123][0-9]|172\.30\.249\.[2-9]|172\.30\.249\.[12][0-9])$/ {
        service {
            ["nginx"]:
            require => Exec["compile"],
            subscribe => File["nginx.conf","/etc/init.d/nginx"],
            binary => "/usr/local/nginx/sbin/nginx",
            pattern => "nginx",
            start => "/usr/local/nginx/sbin/nginx",
            stop => "/usr/local/nginx/sbin/nginx -s stop",
            restart => "/usr/local/nginx/sbin/nginx -s reload",
            #hasrestart => false,
            #hasstatus => true,
            #enable => true,
            ensure => running;
        }
    } else {
        service {
            ["nginx"]:
            require => Exec["compile"],
            #subscribe => File["nginx.conf","/etc/init.d/nginx"],
            binary => "/usr/local/nginx/sbin/nginx",
            pattern => "nginx",
            start => "/usr/local/nginx/sbin/nginx",
            stop => "/usr/local/nginx/sbin/nginx -s stop",
            restart => "/usr/local/nginx/sbin/nginx -s reload",
            ensure => stopped;
        }
    }


}
