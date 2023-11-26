#!/usr/bin/perl

my @DIRS = ("/home/michael/Documents",
            	"/home/michael/bin",
		"/home/michael/Image Repository");

my $backup_dst = "/home/michael/Dropbox";


foreach ( @DIRS ) {
	print "backing up directory $_...";
	my $cmdout = `rsync -a -v --size-only --exclude='Downloads' --exclude='.*' "$_" $backup_dst`;
	if ( $? == -1 )
	{
  		print "command failed: $! $cmdout\n";
	}
	else
	{
		print "done\n";
	}
}

my @MEKE_DIRS = ("/home/meke/Documents",
                 "/home/meke/Image Repository");

$backup_dst = "/home/michael/Dropbox/meke";


foreach ( @MEKE_DIRS ) {
	print "backing up directory $_...";
	my $cmdout = `rsync -a -v --size-only --exclude='Downloads' --exclude='.*' "$_" $backup_dst`;
	if ( $? == -1 )
	{
  		print "command failed: $! $cmdout\n";
	}
	else
	{
		print "done\n";
	}
}

my @MICHELE_DIRS = ("/home/michele/Documents");

$backup_dst = "/home/michael/Dropbox/michele";


foreach ( @MICHELE_DIRS ) {
	print "backing up directory $_...";
	my $cmdout = `rsync -a -v --size-only --exclude='Downloads' --exclude='.*' "$_" $backup_dst`;
	if ( $? == -1 )
	{
  		print "command failed: $! $cmdout\n";
	}
	else
	{
		print "done\n";
	}
}

my @GABBY_DIRS = ("/home/gabby/Documents");

$backup_dst = "/home/michael/Dropbox/gabby";


foreach ( @GABBY_DIRS ) {
	print "backing up directory $_...";
	my $cmdout = `rsync -a -v --size-only --exclude='Downloads' --exclude='.*' "$_" $backup_dst`;
	if ( $? == -1 )
	{
  		print "command failed: $! $cmdout\n";
	}
	else
	{
		print "done\n";
	}
}
