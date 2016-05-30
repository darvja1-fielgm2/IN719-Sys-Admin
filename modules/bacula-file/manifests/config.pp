class bacula-file::config{
  	if $hostname == 'mgmt' {
  		include mgmt-fd
  	}
  	
	elsif $hostname == 'db' {
 		include db-fd
  	}
    	
 	elsif $hostname == 'app' {
 		include app-fd
  	}
  	
	elsif $hostname == 'storage' {
		include storage-fd
	}
}


class bacula-file::mgmt-fd{
   file { "/etc/bacula/bacula-fd.conf":
 		ensure => present,
		source => "puppet:///modules/bacula-file/mgmt-fd.conf",
   		mode => 0444,
   		owner => "bacula",
   		group => "bacula",
  		require => Class["bacula-file::install"],
   		notify => Class["bacula-file::service"],	
  	}
}

class bacula-file::app-fd{
   file { "/etc/bacula/bacula-fd.conf":
	        ensure => present,
        	source => "puppet:///modules/bacula-file/app-fd.conf",
        	mode => 0444,
       		owner => "bacula",
        	group => "bacula",
        	require => Class["bacula-file::install"],
        	notify => Class["bacula-file::service"],
  	}
}

class bacula-file::db-fd{
   file { "/etc/bacula/bacula-fd.conf":
        ensure => present,
        source => "puppet:///modules/bacula-file/db-fd.conf",
        mode => 0444,
        owner => "bacula",
        group => "bacula",
        require => Class["bacula-file::install"],
        notify => Class["bacula-file::service"],
  }
}

class bacula-file::storage-fd{
   file { "/etc/bacula/bacula-fd.conf":
        ensure => present,
        source => "puppet:///modules/bacula-file/storage-fd.conf",
        mode => 0444,
        owner => "bacula",
        group => "bacula",
        require => Class["bacula-file::install"],
        notify => Class["bacula-file::service"],
	}
}
