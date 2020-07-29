#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;
use constant {
	DASH_PATH	=> '/usr/local/bin/dash',
	RMUSER_PATH	=> '/usr/sbin/rmuser',
};

sub main
{
	my $argc = $#ARGV + 1;
	if ($argc < 1) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 1 needed "
			. colored("[user]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	system(
		DASH_PATH,
		'-c',
		RMUSER_PATH . " << EOF
" . $usr . "
y
y
EOF"
		);
	print "Removed git user " . colored($usr, 'bold yellow') . ".\n";
	exit;
}

main();

__END__
