import feedparser
import pprint
feed = feedparser.parse('http://news.google.com/news?pz=1&cf=all&ned=ca&hl=en&topic=w&output=rss')

#print [field for field in feed]
#pprint.pprint(entry for entry in feed['entries'])
#for x in range(0, int(sys.argv[1])):
#for x in feed["items"]:
    #print feed["items"][x]["title"]

titles = [entry.title for entry in feed['entries']]

#print titles[0]
for x in titles:
    print x
