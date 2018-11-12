#!/usr/bin/env python

# cat ~/logs/freenode/##amsterdam-bene/2* | ./learn_karma.py

from __future__ import print_function
import fileinput
import re
import codecs
import sys

viva = re.compile("^[\d:<\s\w]+>\s+(viva|w) (.+)", re.IGNORECASE)
abbasso = re.compile("^[\d:<\s\w]+>\s+(abbasso) (.+)", re.IGNORECASE)

karma = {}
char_stream = codecs.getreader("utf-8")(sys.stdin)

for line in char_stream:
    viva_match = viva.match(line)
    if viva_match:
        element = viva_match.group(2).replace("'", "\\'")
        if element in karma:
            karma[element] += 1
        else:
            karma[element] = 1
    else:
        abbasso_match = abbasso.match(line)
        if abbasso_match:
	    element = abbasso_match.group(2).replace("'", "\\'")
            if element in karma:
                karma[element] -= 1
            else:
                karma[element] = -1
#print (karma)
#print (len(karma))
# $VAR1 = { 'bla' => 'x',  }

print("$VAR1 = {")

for i,n in karma.iteritems():
    print("\t'%s' => '%d'" % (i.encode('utf-8') ,n), end=end)

print ("};")
