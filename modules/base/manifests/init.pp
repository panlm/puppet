class base {
    package {
        "rpmforge-release-0.3.6-1.el5.rf":
        ensure => present,
        provider => rpm,
        source => "http://apt.sw.be/redhat/el5/en/i386/rpmforge/RPMS/rpmforge-release-0.3.6-1.el5.rf.i386.rpm";
    }
    package {
        "siege":
        require => Package["rpmforge-release-0.3.6-1.el5.rf"],
        ensure => installed;
    }
    package {
        ["NetworkManager", "bluez-*"]:
        ensure => purged;
    }
}
