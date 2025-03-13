#!/bin/bash

while true; do
clear
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "==========ARCAEA TERMINAL=========="
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "  ID  |  OPTION"
echo "___________________________________"
echo ""
echo "  1   |  Register New Account"
echo "  2   |  Login to Existing Account"
echo "  3   |  Exit Arcaea Terminal"
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"

read -p "Option: " option

case $option in
   1) bash soal_2/register.sh
      ;;
   2) bash soal_2/login.sh
      ;;
   3) exit 0
      ;;
   *) echo "Invalid option!"
      ;;
esac

read -p "Press enter to return to terminal"
done
