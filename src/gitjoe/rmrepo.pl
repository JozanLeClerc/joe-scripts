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
			. colored("[user - reponame]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $repo = $ARGV[1];
	my $home_dir = HOME_DIR . $usr . '/';
	if (substr($repo, -4) ne '.git') {
		$repo = $repo . '.git';
	}
	$repo = $repo . '/';
	system(
		'/bin/rm',
		'-rfv',
		$home_dir . $repo
		);
	print "Deleted git repository " . colored($repo, 'bold yellow') . " for user " . colored($usr, 'bold') . ".\n";
	exit;
}

main();

__END__
