#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;
use constant GIT_PATH	=> '/usr/local/bin/git';

sub main {
	system(
		GIT_PATH,
		'-C',
		'/usr/local/www/jozan',
		'pull',
		'origin',
		'master'
		);
	system(
		GIT_PATH,
		'-C',
		'/usr/local/www/gitjoe',
		'pull',
		'origin',
		'master'
		);
	system(
		GIT_PATH,
		'-C',
		'/root/scripts',
		'pull',
		'origin',
		'master'
		);
	print "Updated jozan website, git website and scripts.\n";
	exit;
}

main();

__END__
