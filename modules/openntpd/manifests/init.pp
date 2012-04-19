class openntpd {

    case $operatingsystem {

        "OpenBSD": {} # skip install on openbsd because it already has ntpd

        default: {

            $version = "3.9p1"

            group { "_ntp": ensure => present, gid => "183" }
            user  { "_ntp": ensure  => present, gid => "183", uid => "183",
                            comment => "OpenNTP Daemon",
                            shell   => "/sbin/nologin",
                            home    => "/var/empty"
            }

            file { "/usr/local/src": ensure => directory }
            file { "/usr/local/src/openntpd-$version.tar.gz":
                source => "puppet://puppet/openntpd/openntpd-$version.tar.gz",
                alias  => "openntpd-source-tgz",
                before => Exec["untar-openntpd-source"]
            }
            exec { "tar xzf openntpd-$version.tar.gz":
                cwd       => "/usr/local/src",
                creates   => "/usr/local/src/openntpd-$version",
                alias     => "untar-openntpd-source",
                subscribe => File["openntpd-source-tgz"]
            }

            exec { "configure":
                cwd     => "/usr/local/src/openntpd-$version",
                require => Exec[untar-openntpd-source],
                creates => "/usr/local/src/openntpd-$version/config.h",
                before  => Exec["make install"]
            }
            exec { "make && make install":
                cwd     => "/usr/local/src/openntpd-$version",
                alias   => "make install",
                creates => [ "/usr/local/src/openntpd-$version/ntpd",
                             "/usr/local/sbin/ntpd" ],
                require => [Exec["./configure"], Group["_ntp"], User["_ntp"]],
                before  => Service["openntpd"]
            }

        }
    }

    $sbindir = $operatingsystem ? {
        "OpenBSD" => "/usr/sbin", default => "/usr/local/sbin"
    }
    $confdir = $operatingsystem ? {
        "OpenBSD" => "/etc", default => "/usr/local/etc"
    }

    file { "$confdir/ntpd.conf":
        source => "puppet://puppet/openntpd/ntpd.conf",
        before => Service["openntpd"]
    }
    service { "openntpd":
        ensure    => running, provider => base,
        pattern   => "ntpd", start => "$sbindir/ntpd -s"
    }

}
