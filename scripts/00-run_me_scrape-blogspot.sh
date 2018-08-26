#!/bin/bash

OUTPUTFILE=./blogspot.txt
TEMPFOLDER=./blogspot_download
TEMPOUTPUT="$TEMPFOLDER"/tmp_output.txt
PARSER="python parse_blogspot.py"

mkdir -p "$TEMPFOLDER" 2> /dev/null
cd "$TEMPFOLDER"

for site in "https://rispostecristiane.blogspot.de/" "https://666anticristobestia.blogspot.de/2013"; do
    echo "Downloading $site"
    wget -c -A html,txt -r -np -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:57.0) Gecko/20100101 Firefox/57.0" $site
done

cd -
rm -f $OUTPUTFILE
find . -iname *.html -exec sh -c "echo 'Parsing {}' && $PARSER {} >> $OUTPUTFILE" \;

cat ~/logs/freenode/##amsterdam-bene/201* | cut -f2- -d ">"| egrep -v "^(\s*AndreaDi)" | egrep "^ "| grep -v "joins" | egrep -v "^(\s*AndreDePrael)" > our_chats.txt
paste -d'\n' *.txt | tr -s "\n" |  hailo -f - -o 3 -p -b ../20180704-cervello-di-dipre-order3.sqlite
