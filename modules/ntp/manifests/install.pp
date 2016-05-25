class ntp::install {
	package { "ntp" :
		ensure => present,
		require => User["ntp"],
}
user { "ntp":
	ensure => present,
	gid => "ntp",
	shell => "/bin/false", 
	require => Group["ntp"],
}
group {"ntp":
	ensure => present,
}
}	
