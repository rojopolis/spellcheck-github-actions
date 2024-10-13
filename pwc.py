#!python3

# read file and interpret it as yaml
def read_yaml(file):

	with open(file) as f:
		data = yaml.safe_load(f)
	return data

import sys
import yaml
#import pprint
from wcmatch import glob

# read filename from command line as first argument
spellcheck_configuration_file = sys.argv[1]

data = read_yaml(spellcheck_configuration_file)

# fetch the sources from the YAML data
sources = data.get('matrix')[0].get('sources')

# print the sources from the YAML data
#pprint.pprint(sources)

for changed_file in sys.stdin:
	if 'q' == changed_file.rstrip():
		break
	changed_file = changed_file.rstrip()
	#print(f'Input : {changed_file}')

	matched = glob.globmatch(changed_file, sources, flags=glob.NEGATE | glob.GLOBSTAR | glob.SPLIT)

	if matched:
		#print("Matched file:", changed_file)
		exit(0)
	else:
		#print("No match for file:", changed_file)
		exit(1)

#pprint.pprint(files)
