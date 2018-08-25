#!/usr/bin/env python

# cat ~/logs/freenode/##amsterdam-bene/2* | ./learn_karma.py

from __future__ import print_function
import fileinput
import re
import codecs
import sys
import sqlite3

viva = re.compile("^\[(?P<time>.*?)\]\s<(?P<nick>.*?)>\s(viva|w)\s(?P<toBeIncreased>.*?)$", re.IGNORECASE)
abbasso = re.compile("^\[(?P<time>.*?)\]\s<(?P<nick>.*?)>\s(abbasso)\s(?P<toBeDecreased>.*?)$", re.IGNORECASE)

karma = {}
count = 0
char_stream = codecs.getreader("latin-1")(sys.stdin)

for line in char_stream:
    count += 1
    viva_match = viva.match(line)
    if viva_match:
        element = viva_match.group("toBeIncreased").replace("'", "\\'")
        if element in karma:
            karma[element] += 1
        else:
            karma[element] = 1
    else:
        abbasso_match = abbasso.match(line)
        if abbasso_match:
	    element = abbasso_match.group("toBeDecreased").replace("'", "\\'")
            if element in karma:
                karma[element] -= 1
            else:
                karma[element] = -1

db = sqlite3.connect('karma.db')

cursor = db.cursor()
cursor.execute('CREATE TABLE IF NOT EXISTS "Karmas" ( "Name" TEXT NOT NULL CONSTRAINT "PK_Karmas" PRIMARY KEY, "Score" INTEGER NOT NULL )')
db.commit()

for the_key, the_value in karma.iteritems():
    cursor.execute('''INSERT INTO Karmas(Name, Score)
                  VALUES(?,?)''', (the_key,the_value))
    db.commit()
db.close()
