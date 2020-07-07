#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	my $homedir = '/usr/home/';
	my @users;
	opendir(DIR, $homedir);
	my $i = 0;
	while (my $dir = readdir(DIR)) {
		next if ($dir eq 'git-ro');
		next if ($dir =~ m/^\./);
		$users[$i] = $dir;
		$i += 1;
	}
	closedir(DIR);
	$i = 0;
	while ($i < @users) {
		print $users[$i] . "\n";
		$i += 1;
	}
	exit;
}

main();

__END__
