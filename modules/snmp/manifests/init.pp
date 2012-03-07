class snmp {
    package {
        ["net-snmp","sysstat"]:
        ensure => installed;
    }
    file {
        "/etc/snmp/snmpd.conf":
        require => Package["net-snmp"],
        source => "puppet://$fileserver/snmp/snmpd.conf";
    }
    file {
        "/etc/snmp/iostat.sh":
        require => Package["net-snmp","sysstat"],
        mode => 0755,
        source => "puppet://$fileserver/snmp/iostat.sh";
    }
    cron {
        cron_run_per_min:
        command => "/etc/snmp/iostat.sh >/etc/snmp/iostat.sh.log 2>&1",
        user => root;
    }
    service {
        ["snmpd"]:
        subscribe => File["/etc/snmp/snmpd.conf"],
        hasrestart => true,
        hasstatus => true,
        ensure => running;
    }
}

