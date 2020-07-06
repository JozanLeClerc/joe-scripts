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
	my $sshkey = $ARGV[2];
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
	system(
		'/usr/local/bin/dash',
		'-c',
		'/bin/mkdir -v ' . $home_dir . '.ssh'
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/sbin/chown -v ' . $usr . ':' . $usr . ' ' . $home_dir . '.ssh'
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/bin/chmod -v 700 ' . $home_dir . '.ssh/'
		);
	open(my $fh, '>:encoding(UTF-8)', $home_dir . '.ssh/authorized_keys');
	print $fh "$sshkey\n";
	close($fh);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/usr/sbin/chown -v ' . $usr . ':' . $usr . ' ' . $home_dir . '.ssh/authorized_keys'
		);
	system(
		'/usr/local/bin/dash',
		'-c',
		'/bin/chmod -v 600 ' . $home_dir . '.ssh/authorized_keys'
		);
}

main();

__END__
