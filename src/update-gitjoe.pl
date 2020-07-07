#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;

sub get_repos_index {
	my $user = $_[0];
	my $home_dir = '/usr/home/' . $user . '/';
	opendir(DIR, $home_dir);
	my @repos;
	my $i = 0;
	while (my $dir = readdir(DIR)) {
		next if ($dir =~ m/^\./);
		next if (!(-e $home_dir . $dir . '/git-daemon-export-ok'));
		$repos[$i] = $dir;
		$i += 1;
	}
	$i = 0;
	print 'User - ' . colored($user, 'bold') . " - repositories: \n";
	while ($i < @repos) {
		print $repos[$i] . "\n";
		$i += 1;
	}
	closedir(DIR);
	print "\n";
	return @repos;
}

sub stagit_generate {
	my ($user, @repos) = @_;
	my $i = 0;
	my $site_dir = '/usr/local/www/git-jozan/';
	chdir($site_dir);
	while ($i < @repos) {
		$i += 1;
	}
	return;
}

sub main {
	my $home_dir = '/usr/home/';
	my @users;
	opendir(DIR, $home_dir);
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
		my @repos = get_repos_index($users[$i]);
		stagit_generate($users[$i], @repos);
		$i += 1;
	}
	exit;
}

main();

__END__
