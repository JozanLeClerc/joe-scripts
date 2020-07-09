#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	system(
		'/usr/local/bin/dash',
		'-c',
		'git -C /usr/local/www/jozan pull >/dev/null 2>&1'
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'git -C /usr/local/www/git-jozan pull >/dev/null 2>&1'
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'git -C /root/scripts pull >/dev/null 2>&1'
		);
	print "Updated jozan website, git website and scripts.\n";
	exit;
}

main();

__END__
