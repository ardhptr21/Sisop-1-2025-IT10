#!/bin/sh

clear
ram=$( free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2}' )
aval=$( free -m | awk '/Mem:/ {print $7}' )
chache=$( free -m | awk '/Mem:/ {print $6}' )
total=$( free -m | awk '/Mem:/ {print $2}' )

echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "==========ARCAEA TERMINAL=========="
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "Fragment    | "
echo "___________________________________"
echo ""
echo "Total       | $total MB"
echo "Usage       | $ram"
echo "Available   | $aval MB"
echo "Cached      | $chache MB"
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo ""
read -p "Press Enter to exit" 

