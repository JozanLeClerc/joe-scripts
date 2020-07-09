#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	my $argc = $#ARGV + 1;
	if ($argc < 3) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 3 needed "
			. colored("[user - reponame - new owner]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $repo = $ARGV[1];
	my $owner = $ARGV[2];
	my $home_dir = '/usr/home/' . $usr . '/';
	if (substr($repo, -4) ne '.git') {
		$repo = $repo . '.git';
	}
	$repo = $repo . '/';
	open(my $owner_fh, '>:encoding(utf-8)', $home_dir . $repo . 'owner');
	print $owner_fh $owner;
	close($owner_fh);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/sbin/chown -v ' . $usr . ':' . $usr . ' ' . $home_dir . $repo . 'owner'
		);
	substr($repo, -1) = "";
	print "Changed git repository " . colored($repo, 'bold green') . " owner for user " . colored($usr, 'bold') . ".\n"
		"New owner: ". colored($owner, 'bold green') . ".\n";
	exit;
}

main();

__END__
