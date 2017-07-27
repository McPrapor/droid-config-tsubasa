#!/bin/sh

USLEEP="0.2";
OL=-1;

while true; do
  sleep $USLEEP;
  BR=$(stat -c%Z /sys/class/leds/lcd-backlight_1/brightness);
  if [ $BR -gt $OL ]; then
    OL=$BR;
    cat /sys/class/leds/lcd-backlight_1/brightness > /sys/class/leds/lcd-backlight_2/brightness;
  fi;
done
