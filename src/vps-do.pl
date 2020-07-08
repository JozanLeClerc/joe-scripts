#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	my $argc = $#ARGV + 1;
	if ($argc < 1) {
		print colored("Failed!\n", 'bold red')
			. 'Missing argument, at least 2 needed '
			. colored("[script-invoke - (argument(s))]\n", 'bold');
		exit 1;
	}
	my $scripts_dir = '/root/scripts/src/';
	my $called_script = '';
	my $word = '';
	my $ssh_boy = 'root@jozanleclerc.xyz';
	if (
		$ARGV[0] eq 'addsshkey' ||
		$ARGV[0] eq 'chdesc' ||
		$ARGV[0] eq 'chowner' ||
		$ARGV[0] eq 'newrepo' ||
		$ARGV[0] eq 'newuser' ||
		$ARGV[0] eq 'rmrepo' ||
		$ARGV[0] eq 'rmuser'
		) {
		$called_script = $scripts_dir . 'gitjoe/' . $ARGV[0] . '.pl';
	}
	elsif (
		$ARGV[0] eq "update-gitjoe" ||
		$ARGV[0] eq "update-vps"
		) {
		$word = $ARGV[0];
		$word =~ s/update-//;
		$called_script = $scripts_dir . 'update/' . $word . '.pl';
	}
	else {
		print colored("Failed!\n", 'bold red')
			. colored($ARGV[0], 'bold yellow')
			. ": unknown script. Known scripts are:\n"
			. colored("addsshkey\n", 'bold green')
			. colored("chdesc\n", 'bold green')
			. colored("chowner\n", 'bold green')
			. colored("newrepo\n", 'bold green')
			. colored("newuser\n", 'bold green')
			. colored("rmrepo\n", 'bold green')
			. colored("rmuser\n", 'bold green')
			. colored("update-gitjoe\n", 'bold green')
			. colored("update-vps\n", 'bold green');
		exit 2;
	}
	print "Calling " . colored($called_script, 'bold green') . " via " . colored($ssh_boy, 'bold') . "...\n";
	exit;
}

main();

__END__
