#!/bin/bash

function addCronCPU {
  if crontab -l | grep -q "core_monitor.sh"; then
    echo "Error: Core cpu is already monitored"
    return 1
  fi
  local script="$(pwd)/scripts/core_monitor.sh"
  local schedule='* * * * *'
  (crontab -l; echo "$schedule $script") | crontab - 2>/dev/null
}


function addCronRAM {
  if crontab -l | grep -q "frag_monitor.sh"; then
    echo "Error: Fragment ram is already monitored"
    return 1
  fi
  local script="$(pwd)/scripts/frag_monitor.sh"
  local schedule='* * * * *'
  (crontab -l; echo "$schedule $script") | crontab - 2>/dev/null
}

function removeCronCPU {
  if ! crontab -l | grep -q "core_monitor.sh"; then
    echo "Error: Core cpu is not monitored"
    return 1
  fi
  crontab -l | grep -v "core_monitor.sh" | crontab -
}

function removeCronRAM {
  if ! crontab -l | grep -q "frag_monitor.sh"; then
    echo "Error: Fragment ram is not monitored"
    return 1
  fi
  crontab -l | grep -v "frag_monitor.sh" | crontab -
}

function showCrontab {
  if [ -z "$(crontab -l)" ]; then
    echo "No scheduled monitoring jobs"
  else
    crontab -l
  fi
}


while true; do
  clear
  echo "╔═════════════════════════════════════════════════════╗"
  echo "║              ARCAEA TERMINAL                        ║"
  echo "╠════╦════════════════════════════════════════════════╣"
  echo "║ ID ║ OPTION                                         ║"
  echo "╠════╬════════════════════════════════════════════════╣"
  echo "║  1 ║ Add CPU - Core Monitor to Crontab              ║"
  echo "║  2 ║ Add RAM - Fragment Monitor to Crontab          ║"
  echo "║  3 ║ Remove CPU - Core Monitor from Crontab         ║"
  echo "║  4 ║ Remove RAM - Fragment Monitor from Crontab     ║"
  echo "║  5 ║ View All Scheduled Monitoring Jobs             ║"
  echo "║  6 ║ Exit Arcaea Terminal                           ║"
  echo "╚════╩════════════════════════════════════════════════╝"

  read -p "Enter option [1-6]: " option

  case $option in
    1) addCronCPU
        ;;
    2) addCronRAM
        ;;
    3) removeCronCPU
        ;;
    4) removeCronRAM
        ;;
    5) showCrontab
        ;;
    6) exit 0
        ;;
    *) echo "Invalid option!"
        ;;
  esac

  read -p "Press enter to return to terminal"
done
