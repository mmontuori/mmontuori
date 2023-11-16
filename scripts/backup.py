#!/usr/bin/env python3

import sys
import configparser
import os.path
import tarfile
import logging
from optparse import OptionParser

parser = OptionParser(version="%prog v0.1\n(C)2014 Michael Montuori. All rights reserved.",description="utility to create tgz backup files for backup purposes")
parser.add_option("-f", "--file", dest="config_file", help="configuration file", metavar="FILE", default="./backup.conf")
parser.add_option("-o", "--overwrite", action="store_true", default=False, dest="overwrite", help="overwrite existing files")
(options, args) = parser.parse_args()

if options.config_file == None:
        parser.error("invalid -f configuration file")

if os.path.isfile(options.config_file) == False:
        parser.error(options.config_file+" is not a valid file")
        exit(1)

config = configparser.ConfigParser()
config.read(options.config_file)

sections = config.sections()

debug = config.get('default','debug')

if debug == 'true':
        logging.basicConfig(format='%(asctime)s - %(levelname)-8s - %(message)s',level=logging.DEBUG)
        logging.warning("running in debug mode")
else:
        logging.basicConfig(format='%(asctime)s - %(levelname)-8s - %(message)s',level=logging.INFO)
        logging.info("running in info mode")

logging.info("using configuration file: " + options.config_file)
        
for section in sections:
        if section != 'default' and \
           section != 'paths':
                logging.error("invalid configuration section '" + section + "' found in config file: " + config_file)
                exit(1)

dirs = config.get('paths','dirlist')
backup_dir = config.get('paths','backup_dir')

dirarray = dirs.split('\n')

for dir in dirarray:
        if dir == '':
                continue
        try:
                logging.info('backing up...' + dir)
                rsync_cmd="rsync -avzhP " + dir + " " + backup_dir
                os.system(rsync_cmd)
        except Exception as err:
                logging.critical('ERROR: %s\n' % str(err))
