class nrpe::config {
	if $hostname == 'db'{
		include db_nrpe
	}
	elsif $hostname == 'app'{
		include app_nrpe
	}
	elsif $hostname == 'storage'{
		include storage_nrpe
	}
}

class nrpe::db_nrpe{
	file { "/etc/nagios/nrpe.cfg":
		ensure => present,
		source => 'puppet:///modules/nrpe/db_nrpe.cfg',
		mode => 0444,
		require => Class["nrpe::install"],
		notify => Class["nrpe::service"],
	}
}

class nrpe::app_nrpe{
	file { "/etc/nagios/nrpe.cfg":
		ensure => present,
		source => 'puppet:///modules/nrpe/app_nrpe.cfg',
		mode => 0444,
		require => Class["nrpe::install"],
		notify => Class["nrpe::service"],
	}
}

class nrpe::storage_nrpe{
	file { "/etc/nagios/nrpe.cfg":
		ensure => present,
		source => 'puppet:///modules/nrpe/storage_nrpe.cfg',
		mode => 0444,
		require => Class["nrpe::install"],
		notify => Class["nrpe::service"],
	}
}
