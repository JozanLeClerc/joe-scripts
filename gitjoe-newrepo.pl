#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
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
	$repo = $repo . '/';
	system(
		'/usr/local/bin/dash',
		'-c',
		'/bin/mkdir -v ' . $home_dir . $repo
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/local/bin/git -C ' . $home_dir . $repo . ' init --bare'
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/sbin/chown -v -R ' . $usr . ':' . $usr . ' ' . $home_dir . $repo
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/bin/touch ' .  $home_dir . $repo . 'git-daemon-export-ok'
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/sbin/chown -v ' . $usr . ':' . $usr . ' ' . $home_dir . $repo . 'git-daemon-export-ok'
		);
	open(my $owner_fh, '>:encoding(utf-8)', $home_dir . $repo . 'owner');
	print $owner_fh $usr;
	close($owner_fh);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/sbin/chown -v ' . $usr . ':' . $usr . ' ' . $home_dir . $repo . 'owner'
		);
	open(my $url_fh, '>:encoding(utf-8)', $home_dir . $repo . 'url');
	chomp($repo);
	print $url_fh 'git://jozanleclerc.xyz/' . $usr . '/' . chomp($repo);
	close($url_fh);
	$repo = $repo . '/';
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/sbin/chown -v ' . $usr . ':' . $usr . ' ' . $home_dir . $repo . 'url'
		);
	exit;
}

main();

__END__
