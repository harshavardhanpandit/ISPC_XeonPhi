#!/usr/bin/env python 

#import sys
from os import remove
from shutil import move
import re

push = '\t#pragma offload_attribute(push, target(mic))\n'
pop = '\t#pragma offload_attribute(pop)\n'
f = open('offload_ispc.h', 'r')
temp = open('new_header.h', 'w')

i = 0;
flag = 0;
found = -10;
for line in f: 
	#print line,
	i = i + 1
	match = re.search('extern "C" {', line)
	if match:
		found = i
	if i == found + 2:
		#print push
		temp.write(push)
		flag = 1;
	if flag == 1:
		endMatch = re.search('extern', line)
		if not endMatch:
			temp.write(pop)
			flag = 0	

	temp.write(line)


f.close()
temp.close()

remove('offload_ispc.h')
move('new_header.h', 'offload_ispc.h')
