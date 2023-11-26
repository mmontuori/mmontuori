#!/usr/bin/env python

from plexapi.server import PlexServer
from plexapi.myplex import MyPlexAccount
from optparse import OptionParser

parser = OptionParser(version="%prog v0.1\n(C)2017 Michael Montuori. All rights reserved.",description="Montuori Plex Utils")
parser.add_option("-u", "--unwatched", action="store_true", help="list unwatched")
#parser.add_option("-o", "--overwrite", action="store_true", default=False, dest="overwrite", help="overwrite existing files")
(options, args) = parser.parse_args()

account = MyPlexAccount.signin('mmontuori', 'michele1')
plex = account.resource('montuori64').connect()  # returns a PlexServer instance

if options.unwatched:
	for section in plex.library.sections():
		print ("examining section " + section.title)
		for video in section.search(unwatched=True):
			print(video.title, video.TYPE)

#if os.path.isfile(options.config_file) == False:
#	parser.error(options.config_file+" is not a valid file")
#	exit(1)