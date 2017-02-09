#!/usr/bin/python
import json
import sys
import os
from pprint import pprint

json_filename = "raw_data"
json_filedir = "/.conky/weather/"
#json_data = open(sys.argv[1])
json_data = open(os.getenv("HOME")+json_filedir+json_filename)

data = json.load(json_data)
if (len(sys.argv) == 2):
    print (data[sys.argv[1]])
elif (len(sys.argv) == 3):
    print (data[sys.argv[1]][sys.argv[2]])
elif (len(sys.argv) == 4):
    print (data[sys.argv[1]][sys.argv[2]][sys.argv[3]])
else:
    print ("argument needed")

#pprint(data)
#print data["current_observation"]["display_location"]["full"]
#print data["current_observation"]["weather"]
#print "Temp", data["current_observation"]["temp_f"], "F RH ",\
    #data["current_observation"]["relative_humidity"]
#print "Wind: ", data["current_observation"]["wind_string"]
json_data.close()
