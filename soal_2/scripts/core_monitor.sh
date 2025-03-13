#!/bin/sh

while true; do
clear
username=$(cut -d ',' -f2 session.txt)

echo "Signed as $username"
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "==========ARCAEA TERMINAL=========="
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "  ID  |  OPTION"
echo "___________________________________"
echo ""
echo "  1   |  Check CPU Usage Percentage"
echo "  2   |  Check CPU Model"
echo "  3   |  Frag Monitor"
echo "  4   |  Open Crontab Manager"
echo "  0   |  Exit"
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
read -p "Option: " option

case $option in
   1) usage=$( top -bn2 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}' | awk 'NR==2 {print $0}' )      
      echo -e "Your CPU usage percentage is \e[31m$usage\e[0m"
      ;;
   2) model=$( cat /proc/cpuinfo | grep 'name'| uniq | awk -F': ' '{print $2}' )
      echo -e "\e[31m$model\e[0m"
      ;;
   3) bash frag_monitor.sh
      ;;
   4) bash manager.sh
      ;;
   0) break
      ;;
   *) echo "Invalid option!"
      ;;
esac

read -p "Press enter to return to menu"
done
