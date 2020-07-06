#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub main {
	my $argc = $#ARGV + 1;
	if ($argc < 3) {
		print colored("Failed!\n", 'bold red')
			. "Missing argument, 2 needed "
			. colored("[user - password - ssh public key]", 'bold')
			. "\n";
		exit 1;
	}
	my $usr = $ARGV[0];
	my $pass = $ARGV[1];
	my $home_dir = '/usr/home/' . $usr . '/';
	system(
		'/usr/local/bin/dash',
		'-c',
		"adduser << EOF
" . $usr . "





git-shell





" . $pass . "
" . $pass . "

yes
no
EOF"
		);
	my $gitshell_cmds = "cd
touch
git
ls";
	open(my $fh, '>:encoding(UTF-8)', $home_dir . 'git-shell-commands');
	print $fh $gitshell_cmds;
	close($fh);
}

main();

__END__
