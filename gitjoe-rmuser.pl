#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
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
		'/usr/local/bin/dash',
		'-c',
		"rmuser << EOF
" . $usr . "
y
y
EOF"
		);
	exit;
}

main();

__END__
