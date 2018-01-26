#!/bin/bash

outp=$(bwm-ng -o csv -C ' ' -c 1 | grep wlan0 | awk '{printf "%d %d", $3, $4}')
                   # name of the interface^ you want or 'total' 4 all
up=${outp% *}
dl=${outp#* }
dunit="Bps"
uunit="Bps"

if [ $dl -ge 1000 ] && [ $dl -le 1000000 ]; then
  dunit="KBps"
  dl=$(echo "$dl" | awk '{printf("%d",$1 / 1000 + 0.5)}')
elif [ $dl -ge 1000000 ]; then
  dunit="MBps"
  dl=$(echo "$dl" | awk '{printf("%d",$1 / 1000000 + 0.5)}')
fi
if [ $up -ge 1000 ] && [ $dl -le 1000000 ]; then
  uunit="KBps"
  up=$(echo "$up" | awk '{printf("%d",$1 / 1000 + 0.5)}')
elif [ $up -ge 1000000 ]; then
  uunit="MBps"
  up=$(echo "$up" | awk '{printf("%d",$1 / 1000000 + 0.5)}')
fi

drop=$(bwm-ng -o plain -c 1 | head -n 10 | tail -n 7 | awk '{ORS="\\n"};1')

socketstat=$(ss -s | awk '{ORS="\\n"};1') # ⇡ ⇣ ⇃ ↾

echo "<big>⇣</big>$dl<small>$dunit</small><big></big><big>⇡</big>$up"\
"<small>$uunit</small> | font=monospace size=8 color=#33BEFF refresh=true"
echo "---"
echo "$drop | size=8 font=monospace trim=false bash='bwm-ng; touch $0'"
echo "---"
echo "$socketstat | size=8 font=monospace | bash='ss | less'" # ss -a -A udp
