\#!/bin/sh

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
echo "  1   |  Check CPU Model"
echo "  2   |  Frag Monitor"
echo "  3   |  Open Crontab Manager"
echo "  0   |  Exit"
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
read -p "Option: " option

case $option in
   1) model=$( cat /proc/cpuinfo | grep 'name'| uniq | awk -F': ' '{print $2}' )
      echo -e "\e[31m$model\e[0m"
      ;;
   2) bash frag_monitor.sh
      ;;
   3) bash manager.sh
      ;;
   0) break
      ;;
   *) echo "Invalid option!"
      ;;
esac

read -p "Press enter to return to menu"
done
