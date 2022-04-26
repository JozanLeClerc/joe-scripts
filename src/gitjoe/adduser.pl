#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;
use constant HOME_DIR => '/usr/local/git/';

sub main
{
	my $argc = $#ARGV + 1;
	if ($argc < 2) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 2 needed "
			. colored("[user - ssh public key]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $sshkey = "no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ";
	$sshkey = $sshkey . $ARGV[1];
	my $home_dir = HOME_DIR . $usr . '/';
	system(
		"adduser << EOF
" . $usr . "





git-shell
" . HOME_DIR . $usr . "



yes

yes
no
EOF"
		);
	my (undef, undef, $uid, $gid) = getpwnam($usr);
	mkdir $home_dir . '.ssh/', 0700;
	chown $uid, $gid, $home_dir . '.ssh/';
	open(my $fh, '>:encoding(UTF-8)', $home_dir . '.ssh/authorized_keys');
	print $fh $sshkey . "\n";
	close($fh);
	chown $uid, $gid, $home_dir . '.ssh/authorized_keys';
	chmod 0600, $home_dir . '.ssh/authorized_keys';
	print "Created new git user " . colored($usr, 'bold green') . ".\n";
	exit;
}

main();

__END__
