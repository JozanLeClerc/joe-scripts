#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	my $argc = $#ARGV + 1;
	if ($argc < 2) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 2 needed "
			. colored("[user - ssh public key]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $sshkey = $ARGV[1];
	my $home_dir = '/usr/home/' . $usr . '/';
	open(my $fh, '>:encoding(UTF-8)', $home_dir . '.ssh/authorized_keys');
	print $fh "$sshkey\n";
	close($fh);
	exit;
}

main();

__END__
