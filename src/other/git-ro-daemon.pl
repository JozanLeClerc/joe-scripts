#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/local/bin/git daemon --reuseaddr --base-path=/usr/home /usr/home &'
		);
	exit;
}

main();

__END__
