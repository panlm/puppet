class siege {
    file {
        "/usr/local/bin/run_siege.sh":
        source => "puppet://$fileserver/siege/run_siege.sh",
        mode => 0755;
    }
}

