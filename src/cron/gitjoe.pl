#!/usr/local/bin/perl

use strict;
use warnings;
use Term::ANSIColor;
use File::Copy;
use Capture::Tiny;

use constant {
	HOME_DIR	=> '/usr/local/git/',
	TMP_DIR		=> '/tmp/gitjoe/',
	SITE_DIR	=> '/usr/local/www/gitjoe/'
};

sub get_repos_index {
	my $user = $_[0];
	my $home_dir = HOME_DIR . $user . '/';
	opendir(DIR, $home_dir);
	my @repos;
	my $i = 0;
	while (my $dir = readdir(DIR)) {
		next if ($dir =~ m/^\./);
		next if (!(-e $home_dir . $dir . '/git-daemon-export-ok'));
		$repos[$i] = $dir;
		$i += 1;
	}
	closedir(DIR);
	@repos = sort @repos;
	return @repos;
}

sub stagit_generate {
	my ($user, @repos) = @_;
	my $home_dir = HOME_DIR . $user . '/';
	chdir(TMP_DIR);
	mkdir($user . '/', 0755);
	my $i = 0;
	my $repos_line = "";
	copy(SITE_DIR . 'css/gitjoe.css', './' . $user . '/style.css');
	copy(SITE_DIR . 'img/logo.png', './' . $user . '/logo.png');
	while ($i < @repos) {
		chdir(TMP_DIR . $user . '/');
		$repos_line = $repos_line . ' ' . $home_dir . $repos[$i] . '/';
		substr($repos[$i], -4) = "";
		mkdir($repos[$i] . '/', 0755);
		chdir(TMP_DIR . $user . '/' . $repos[$i] . '/');
		$repos[$i] = $repos[$i] . '.git';
		print "Indexing " . colored($user . '/' . $repos[$i], 'bold') . ".\n";
		system(
			'stagit',
			$home_dir . $repos[$i] . '/'
		);
		copy('../style.css', './style.css');
		copy('../logo.png', './logo.png');
		$i += 1;
	}
	chdir(TMP_DIR . $user . '/');
	system(
		'stagit-index ' . $repos_line . '>index.html'
	);
	system(
		"sed -i '' -e 's/<td>" . $user . "<\\/td>/<td class=\"td_author\">" . $user . "<\\/td>/g' index.html"
	);
	system(
		"sed -i '' -e 's/<td><span class=\"desc\">Repositories<\\/span><\\/td>/<td><span class=\"desc\"><h1>" . $user . " - Repositories<\\/h1><\\/span><\\/td><\\/tr><tr><td><\\/td><td>Back to <a href=\"https:\\/\\/gitjoe.xyz\\/\">GitJoe<\\/a><\\/td><\\/tr>/' index.html"
	);
	system("sed -i '' -e 's/log.html/files.html/g' index.html");
	return;
}

sub main {
	my $home_dir = HOME_DIR;
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
	mkdir(TMP_DIR, 0755);
	while ($i < @users) {
		my @repos = get_repos_index($users[$i]);
		stagit_generate($users[$i], @repos);
		print "Removing user " . colored($users[$i], 'bold green') . " old directory from " . colored(SITE_DIR, 'bold') . ".\n";
		system(
			'rm',
			'-rf',
			SITE_DIR . $users[$i]
		);
		print "Moving user " . colored($users[$i], 'bold green') . " newly generated directory to " . colored(SITE_DIR, 'bold') . ".\n";
		move(TMP_DIR . $users[$i], SITE_DIR . $users[$i]);
		$i += 1;
	}
	rmdir(TMP_DIR);
	print "Updated GitJoe index.\n";
	exit;
}

main();

__END__
