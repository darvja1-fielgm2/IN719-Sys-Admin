class bacula-storage::config {
	file { "/etc/bacula/bacula-sd.conf":
		ensure => present,
		source => "puppet:///modules/bacula-storage/bacula-sd.conf",
		mode => 0444,
		owner => "root",
		group => "root",
		require => Class["bacula-storage::install"],
		notify => Class["bacula-storage::service"],
	}
}
