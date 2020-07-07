#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	my $argc = $#ARGV + 1;
	if ($argc < 2) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 3 needed "
			. colored("[user - reponame - description]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $repo = $ARGV[1];
	my $desc = $ARGV[2];
	my $home_dir = '/usr/home/' . $usr . '/';
	if (substr($repo, -4) ne '.git') {
		$repo = $repo . '.git';
	}
	$repo = $repo . '/';
	open(my $desc_fh, '>:encoding(utf-8)', $home_dir . $repo . 'description');
	print $desc_fh $desc;
	close($desc_fh);
	exit;
}

main();

__END__
