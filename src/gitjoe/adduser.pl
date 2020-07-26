#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	my $argc = $#ARGV + 1;
	if ($argc < 3) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 3 needed "
			. colored("[user - password - ssh public key]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $pass = $ARGV[1];
	my $sshkey = "no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ";
	$sshkey = $sshkey . $ARGV[2];
	my $home_dir = '/usr/home/' . $usr . '/';
	system(
		'/usr/local/bin/dash',
		'-c',
		"adduser << EOF
" . $usr . "





git-shell





" . $pass . "
" . $pass . "

yes
no
EOF"
		);
	my ($login, $passwd, $uid, $gid) = getpwnam($user);
	mkdir $home_dir . '.ssh/', 0700;
	chown $uid, $gid, $home_dir . '.ssh/';
	# system(
	# 	'/usr/sbin/chown',
	# 	'-v',
	# 	$usr . ':' . $usr,
	# 	$home_dir . '.ssh/'
	# 	);
	open(my $fh, '>:encoding(UTF-8)', $home_dir . '.ssh/authorized_keys');
	print $fh $sshkey . "\n";
	close($fh);
	chown $uid, $gid, $home_dir . '.ssh/authorized_keys';
	# system(
	# 	'/usr/sbin/chown',
	# 	'-v',
	# 	$usr . ':' . $usr,
	# 	$home_dir . '.ssh/authorized_keys'
	# 	);
	chmod 0600, $home_dir . '.ssh/authorized_keys';
	# system(
	# 	'/bin/chmod',
	# 	'-v',
	# 	'600',
	# 	$home_dir . '.ssh/authorized_keys'
	# 	);
	print "Created new git user " . colored($usr, 'bold green') . ".\n";
	exit;
}

main();

__END__
