#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	my $argc = $#ARGV + 1;
	if ($argc < 2) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 2 needed "
			. colored("[user - password]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	system(
		'/usr/local/bin/dash',
		'-c',
		"adduser << EOF
". $usr . "





git-shell

EOF"
		);
}

main();

__END__
