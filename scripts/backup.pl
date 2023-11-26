#!/usr/bin/perl

my @DIRS = ("/home/michael",
		"/home/meke",
		"/home/michele",
		"/home/gabby");

my $backup_dst = "linux:/home/michael/backup/montuori64";


foreach ( @DIRS ) {
	print "backing up directory $_...";
	my $cmdout = `rsync -a -v --size-only --exclude='Downloads' --exclude='.*' $_ $backup_dst`;
	if ( $? == -1 )
	{
  		print "command failed: $! $cmdout\n";
	}
	else
	{
		print "done\n";
	}
}

#rsync -a -v --size-only --exclude='Downloads' --exclude='.*' /home/michael linux:/home/michael/backup/montuori64
#rsync -a -v Image\ Repository linux:/home/michael/backup/montuori64
#rsync -a -v Documents linux:/home/michael/backup/montuori64
#rsync -a -v Pictures linux:/home/michael/backup/montuori64
#rsync -a -v Music linux:/home/michael/backup/montuori64
#rsync -a -v /media/3T\ Drive/Videos/Bambini linux:/home/michael/backup/montuori64/Videos
#rsync -a -v /media/3T\ Drive/Videos/Mobile\ Videos linux:/home/michael/backup/montuori64/Videos
