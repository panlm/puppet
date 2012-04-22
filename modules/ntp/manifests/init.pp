class ntp {
    cron {
        cron_ntpdate:
        ensure  => present,
        command => "/usr/sbin/ntpdate -s time.nist.gov ",
        user => root,
        minute => '0',
        hour => '12';
    }
}
