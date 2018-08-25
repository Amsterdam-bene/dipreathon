import sys
import re
from bs4 import BeautifulSoup

reload(sys)
sys.setdefaultencoding('utf8')

try:
    infile = open(sys.argv[1],'r').read()
except:
    infile = sys.stdin.read()


def cleantext(text):
    if text:
       clean = re.sub("\n|\r", " ", text)
       clean = re.sub('<!--.*-->', '', clean, flags=re.DOTALL)
       clean = re.sub('\[if .*\[endif\]', '', clean, flags=re.DOTALL)
       clean = re.sub("\s+", " ", clean, flags=re.MULTILINE)
       clean = re.sub("\s*\.+", ".", clean, flags=re.MULTILINE)
       # dots are new lines only if it's not followed by a "c" (as in a.c. or d.c.) or prepended with S. (S.Nicola or SS.Madre) and fllowed by space
       clean = re.sub("(?<![sS])\.(?![cC]) ", ".\n", clean)
       # Break on ! and ?
       clean = re.sub("(?<=[!?])(?=.)", "\n", clean)
       clean = re.sub("^\s*[!?]\s*$", "", clean, flags=re.MULTILINE)
       clean = re.sub("^\s+", "", clean, flags=re.MULTILINE)
       return clean + "\n"
    else:
       return ""
       

soup = BeautifulSoup(infile)

# Posts
for finding in soup.findAll("div", {"id": re.compile("post-body-.+")}):
    print cleantext(finding.text)

# Comments
for finding in soup.findAll(attrs={'class':"comment-content"}):
   print cleantext(finding.text)
