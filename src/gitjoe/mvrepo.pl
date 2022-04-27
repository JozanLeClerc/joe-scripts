#!/usr/local/bin/perl

use strict;
use warnings;
use File::Copy;
use Term::ANSIColor;

use constant HOME_DIR => '/usr/local/git/';

sub main
{
	my $argc = $#ARGV + 1;
	if ($argc < 3) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 3 needed "
			. colored("[user - reponame - new name]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $repo = $ARGV[1];
	my $newname = $ARGV[2];
	my $home_dir = HOME_DIR . $usr . '/';
	if (substr($repo, -4) ne '.git') {
		$repo .= '.git';
	}
	if (substr($newname, -4) ne '.git') {
		$newname .= '.git';
	}
	move($home_dir . $repo, $home_dir . $newname);
	print "Changed git repository " . colored($repo, 'bold green')
		. " name to " . colored($newname, 'bold green') . " for user " . colored($usr, 'bold') . ".\n";
	exit;
}

main();

__END__
