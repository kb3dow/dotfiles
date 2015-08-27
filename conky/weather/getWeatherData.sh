#!/bin/bash

#put your hemisphere here: n for north, s for south
hemisphere=n

#put your Weather Underground address API here
address="http://api.wunderground.com/api/df4b73029772dd5d/conditions/forecast10day/astronomy/hourly/satellite/q/MD/Laurel.json"

#rm $HOME/2b_Wunderground_API/*.png

killall -STOP conky
#killall wget

wget -O $HOME/.conky/weather/raw_data $address

#more icons can be found at
#http://www.wunderground.com/weather/api/d/docs?d=resources/icon-sets&MR=1
icon=`python $HOME/.conky/weather/getWeatherField.py  current_observation icon`
cp -f $HOME/.conky/weather/icons/$icon.png $HOME/.conky/weather/now.png

killall -CONT conky

