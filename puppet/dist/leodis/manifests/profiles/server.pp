# == Class: leodis::profiles::server
#
# === Examples
#
#  include leodis::profiles::server
#
class leodis::profiles::server {

	class { 'apache':
		default_vhost => false,
	}
	apache::vhost { 'leodis.ac.uk':
		port          => 80,
		servername    => 'www.leodis.ac.uk',
		serveraliases => ['leodis.ac.uk','leodis.co.uk','www.leodis.co.uk','leodis.net','www.leodis.net'],
		docroot       => '/var/www',
		proxy_pass    => [
			{
				'path'         => '/',
				'url'          => 'http://localhost:1337/',
				'reverse_urls' => ['http://localhost:1337/'],
			},
		],
	}
}
