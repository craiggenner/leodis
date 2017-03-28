if ! $::lsbdistcodename {
	$lsbdistcodename = 'trusty'
}
if ! $::lsbdistid {
	$lsbdistid = 'ubuntu'
}

include leodis::roles::server
