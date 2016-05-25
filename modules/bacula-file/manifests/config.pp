class bacula-file::config {
	file { "/etc/bacula/bacula-fd.conf":
		ensure => present,
		source => "puppet:///modules/bacula-file/bacula-fd.conf",
		mode => 0444,
		owner => "root",
		group => "root",
		require => Class["bacula-file::install"],
		notify => Class["bacula-file::service"],
	}
}
