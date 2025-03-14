#!/bin/sh

RAM=$( free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2}' )
AVAILABLE=$( free -m | awk '/Mem:/ {print $7}' )
CACHE=$( free -m | awk '/Mem:/ {print $6}' )
TOTAL=$( free -m | awk '/Mem:/ {print $2}' )

echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "Total     : $TOTAL MB"
echo "Usage     : $RAM"
echo "Available : $AVAILABLE MB"
echo "Cached    : $CACHE MB"
echo "___________________________________"
