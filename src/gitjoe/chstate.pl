#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

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
	my $home_dir = '/usr/home/' . $usr . '/';
	if (substr($repo, -4) ne '.git') {
		$repo = $repo . '.git';
	}
	my $state;
	if (-e $home_dir . $repo . '/git-daemon-export-ok') {
		unlink($home_dir . $repo . '/git-daemon-export-ok');
		$state = 'private';
	}
	else {
		open(my $fh, '>', $home_dir . $repo . '/git-daemon-export-ok');
		close($fh);
		$state = 'public';
		my (undef, undef, $uid, $gid) = getpwnam($usr);
		chown $uid, $gid, $home_dir . $repo . '/git-daemon-export-ok';
	}
	print "Changed git repository " . colored($repo, 'bold green')
		. " for user " . colored($usr, 'bold green')
		. colored(' visibility state to ', 'bold') . colored($state, 'bold green') . ".\n";
	exit;
}

main();

__END__
