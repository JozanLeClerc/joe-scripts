#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	system(
		'git daemon --reuseaddr --base-path=/usr/local/git /usr/local/git &'
		);
	exit;
}

main();

__END__
