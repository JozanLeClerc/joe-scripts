#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;
use constant HOME_DIR => '/usr/local/git/';

sub main
{
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
	my $home_dir = HOME_DIR . $usr . '/';
	if (substr($repo, -4) ne '.git') {
		$repo = $repo . '.git';
	}
	$repo = $repo . '/';
	open(my $owner_fh, '>:encoding(utf-8)', $home_dir . $repo . 'owner');
	print $owner_fh $owner;
	close($owner_fh);
	substr($repo, -1) = "";
	print "Changed git repository " . colored($repo, 'bold green') . colored(" owner", 'bold') . " for user " . colored($usr, 'bold green') . ".\n"
		. "New owner: ". colored($owner, 'bold green') . ".\n";
	exit;
}

main();

__END__
