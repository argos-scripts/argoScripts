#!/bin/bash

U=$(uptime | awk '{gsub(",", "")} {print $3, $4, $5}')
date=$(uptime -s)
style="font='Linux Biolinum' size=11.5" # Use monospace if you don't have/like the font

if [[ ! "$U" =~ "day" ]];then
  if [[ ! "$U" =~ ":" ]]; then
    up=$(echo "$U" | awk '{ print "0:"$1 }')
  else
    up=$(echo "$U" | awk '{ print $1 }')
  fi
  if [ ${up%%:*} -ge 8 ]; then # color to mark "half the ideal" wake time passing assuming 8hrs of sleep
    style="font='Linux Biolinum' size=11.5 color=#33BEFF"
  fi
  if [[ ${up%%:*} -ge 16 ]]; then # color to mark "ideal" wake time passing assuming 8hrs of sleep
    style="font='Linux Biolinum' size=11.5 color=#f23400"
  fi
else
  if [[ ! "$U" =~ ":" ]]; then
    up=$(echo $U | awk '{ print $1, $2, "0:"$3 }')
  else
    up=$(echo "$U" | awk '{print $1, $2, $3}')
  fi
fi

echo "<span stretch='condensed' style='oblique' weight='ultrabold' gravity='south' gravity_hint='strong'"\
"variant='smallcaps'>ᛊ</span><span font_stretch='ultracondensed' style='italic' weight='ultrabold'>$up</span> | $style"

echo "---"

echo "<b>$date</b> | font='monospace' size=10" # "system up since" on drop down
