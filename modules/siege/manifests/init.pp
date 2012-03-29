class siege {
    #if $hostname =~ /^(vm[0-9]|vm1[0-9])$/ {
    if $hostname =~ /^vm[0-9]$/ {
        file {
            "/usr/local/bin/run_si.sh":
            source => "puppet://$fileserver/siege/run_si.sh",
            alias => 'run_si.sh',
            mode => 0755;
        }
        file {
            "/usr/local/bin/run_si.conf":
            source => "puppet://$fileserver/siege/run_si.conf",
            alias => 'run_si.conf',
            mode => 0644;
        }
        cron {
            run_si_10mins:
            ensure  => present,
            require => File['run_si.sh','run_si.conf'],
            command => "/usr/local/bin/run_si.sh >>/usr/local/bin/run_si.sh.log 2>&1",
            user => root,
            minute => '*/10';
        }
    } elsif $hostname == 'vm11' {
        cron {
            run_si_10mins:
            ensure  => absent;
        }
    } else {
        file {
            "/usr/local/bin/run_si.sh":
            ensure => absent;
        }
        file {
            "/usr/local/bin/run_si.conf":
            ensure => absent;
        }
        cron {
            run_si_10mins:
            ensure  => absent;
        }
    }
}

