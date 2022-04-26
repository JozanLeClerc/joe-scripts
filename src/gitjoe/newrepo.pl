#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;
use File::Find;
use constant HOME_DIR => '/usr/local/git/';

sub main
{
	my $argc = $#ARGV + 1;
	if ($argc < 2) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, at least 2 needed "
			. colored("[user - reponame - (description)]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $repo = $ARGV[1];
	my $desc = "";
	if ($argc >= 3) {
		$desc = $ARGV[2];
	}
	my $home_dir = HOME_DIR . $usr . '/';
	if (substr($repo, -4) ne '.git') {
		$repo = $repo . '.git';
	}
	$repo = $repo . '/';
	mkdir $home_dir . $repo, 0755;
	system(
		'/usr/local/bin/git',
		'-C',
		$home_dir . $repo,
		'init',
		'--bare'
		);
	my (undef, undef, $uid, $gid) = getpwnam($usr);
	find(
		sub {
			chown $uid, $gid, $_;
		},
		$home_dir . $repo
		);
	system(
		'/usr/bin/touch',
		$home_dir . $repo . 'git-daemon-export-ok'
		);
	chown $uid, $gid, $home_dir . $repo . 'git-daemon-export-ok';
	open(my $owner_fh, '>:encoding(UTF-8)', $home_dir . $repo . 'owner');
	print $owner_fh $usr;
	close($owner_fh);
	open(my $url_fh, '>:encoding(UTF-8)', $home_dir . $repo . 'url');
	substr($repo, -1) = "";
	print $url_fh 'git://gitjoe.xyz/' . $usr . '/' . $repo;
	close($url_fh);
	$repo = $repo . '/';
	open(my $desc_fh, '>:encoding(UTF-8)', $home_dir . $repo . 'description');
	if ($argc >= 3) {
		print $desc_fh $desc;
	}
	else {
		print $desc_fh 'No description yet';
	}
	close($desc_fh);
	chown $uid, $gid, $home_dir . $repo . 'description';
	substr($repo, -1) = "";
	print "Created git repository " . colored($repo, 'bold green') . " for user " . colored($usr, 'bold') . ".\n";
	print "Remote url: " . colored($usr . '@gitjoe.xyz:' . $repo, 'bold green') . "\n"
		. "Public clone url: " . colored('git://gitjoe.xyz/' . $usr . '/' . $repo, 'bold green') . "\n";
	exit;
}

main();

__END__
