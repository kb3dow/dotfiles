#!/usr/bin/python
import sys
import os
import feedparser

rssurl = "http://feeds.bbci.co.uk/news/world/us_and_canada/rss.xml"
feed = feedparser.parse(rssurl)

for x in range(0, int(sys.argv[1])):
    print feed["items"][x]["title"]
