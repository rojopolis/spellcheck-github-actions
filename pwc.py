#!python3

# This little helper script was implemented to extract the sources from the spellcheck configuration file
# The name pwc comes from Python WCMatch, which is used to match the files against the sources
# That is the short name I call it PriceWaterhouseCoopers, since it revises the file listing

# read file and interpret it as yaml
def read_yaml(file):

	with open(file) as f:
		data = yaml.safe_load(f)
	return data

import sys
import yaml
from wcmatch import glob

# read filename from command line as first argument
spellcheck_configuration_file = sys.argv[1]

data = read_yaml(spellcheck_configuration_file)

# fetch the sources from the YAML data
sources = data.get('matrix')[0].get('sources')

for changed_file in sys.stdin:
	if 'q' == changed_file.rstrip():
		break
	changed_file = changed_file.rstrip()

	matched = glob.globmatch(changed_file, sources, flags=glob.NEGATE | glob.GLOBSTAR | glob.SPLIT)

	if matched:
		exit(0)
	else:
		exit(1)
