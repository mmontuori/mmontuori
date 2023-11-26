#!/usr/bin/perl

my @DIRS = ("/home/michael/box/box10");

my $backup_dst = "/box";

foreach ( @DIRS ) {
	print "backing up directory $_...";
	my $cmdout = `rsync -a -v --size-only "$_" $backup_dst`;
	if ( $? == -1 )
	{
  		print "command failed: $! $cmdout\n";
	}
	else
	{
		print "\n$cmdout\ndone\n";
	}
}
