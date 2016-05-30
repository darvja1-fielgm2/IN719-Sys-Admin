class nagios::config {
	file { "/etc/nagios3/nagios.cfg":
		ensure => present,
		source => "puppet:///modules/nagios/nagios.cfg",
		mode => 0644,
		owner => "nagios",
		group => "nagios",
		require => Class["nagios::install"],
		notify => Class["nagios::service"],
	}

#defining contacts
	nagios_contact { 'fielgm2':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Greg Field',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r',
		host_notification_options => 'd,r',
		service_notification_commands => 'notify-service-by-email',
		host_notification_commands => 'notify-host-by-email',
		email => 'fielgm2@student.op.ac.nz',
	}
	
	nagios_contact { 'darvja1':
		target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
		alias => 'Jared Darvill-Jackson',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r',
		host_notification_options => 'd,r',
		service_notification_commands => 'notify-service-by-email',
		host_notification_commands => 'notify-host-by-email',
		email => 'darvja1@student.op.ac.nz',
	}
	
	nagios_contact { 'slack':
		target => '/etc/nagios3/conf.d/ppt_slack_nagios.cfg',
		alias => 'Slack',
		service_notification_period => '24x7',
		host_notification_period => '24x7',
		service_notification_options => 'w,u,c,r',
		host_notification_options => 'd,r',
		service_notification_commands => 'notify-service-by-slack',
		host_notification_commands => 'notify-host-by-slack',
	}

#making contact group and adding contacts
	nagios_contactgroup { 'sysadmins':
		target => '/etc/nagios3/conf.d/ppt_contactgroups.cfg',
		alias => 'Systems Administrators',
		members => 'fielgm2, darvja1, slack',
	}

#defining nagios host for db server
	nagios_host { 'db.micro-agents.net':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'db',
		address => '10.25.1.85',
		check_period => '24x7',
		max_check_attempts => 3,
		check_command => 'check-host-alive',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
	}

#defining nagios host for storage server
	nagios_host { 'storage.micro-agents.net':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'storage',
		address => '10.25.1.84',
		check_period => '24x7',
		max_check_attempts => 3,
		check_command => 'check-host-alive',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
	}

#defining nagios host for app server
	nagios_host { 'app.micro-agents.net':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'app',
		address => '10.25.1.88',
		check_period => '24x7',
		max_check_attempts => 3,
		check_command => 'check-host-alive',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
	}

#defining nagios host for ad server
	nagios_host { 'ad.micro-agents.net':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'ad',
		address => '10.25.100.2',
		check_period => '24x7',
		max_check_attempts => 3,
		check_command => 'check-host-alive',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
	}

#defining service
	nagios_service {'MySQL':
		service_description => 'MySQL DB',
		hostgroup_name => 'db-servers',
		target => '/etc/nagios3/conf.d/ppt_mysql_service.cfg',
		check_command => 'check_mysql_cmdlinecred!$USER3$!$USER4$',
		max_check_attempts => 3,
		retry_check_interval => 1,
		normal_check_interval => 5,
		check_period => '24x7',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'w,u,c',
		contact_groups => 'sysadmins',
	}
#define service
	nagios_service { 'nagios-nrpe-server':
	service_description => 'NRPE',
	hostgroup_name => 'remote_disks',
	target => '/etc/nagios3/conf.d/ppt_nrpe_service.cfg',
	check_command => 'check_nrpe_1arg!check_hd',
	max_check_attempts => 3,
	retry_check_interval => 1,
	normal_check_interval => 5,
	check_period => '24x7',
	notification_interval => 30,
	notification_period => '24x7',
	notification_options => 'w,u,c',
	contact_groups => 'sysadmins',
	}

	nagios_service {'ssh':
		service_description => 'SSH',
		hostgroup_name => 'ssh_servers_check',
		target => '/etc/nagios3/conf.d/ppt_ssh_service.cfg',
		check_command => 'check_ssh',
		max_check_attempts => 3,
		retry_check_interval => 1,
		normal_check_interval => 5,
		check_period => '24x7',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'w,u,c',
		contact_groups => 'sysadmins',
	}	
	
#define host group to identify mysql servers to nagios
	nagios_hostgroup{'db-servers':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'Database Servers',
		members => 'db.micro-agents.net',
	}
	nagios_hostgroup{'remote_disks':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'Remote Disks',
		members => 'db.micro-agents.net, storage.micro-agents.net, app.micro-agents.net',
	}
	nagios_hostgroup{'ssh_servers_check':
		target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		alias => 'SSH Servers',
		members => 'db.micro-agents.net, storage.micro-agents.net, app.micro-agents.net, localhost',
	} 	
}
