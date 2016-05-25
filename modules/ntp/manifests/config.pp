class ntp::config {
	file { "/etc/ntp.conf":
		ensure => present,
		source => "puppet:///modules/ntp/ntp.conf",
		mode => 0444,
		owner => "root",
		group => "root",
		require => Class["ntp::install"],
		notify => Class["ntp::service"],
	}
}
