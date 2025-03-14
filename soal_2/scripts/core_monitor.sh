#!/bin/sh

CPU=$( top -bn2 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}' | awk 'NR==2 {print $0}' )
CPU_model=$( cat /proc/cpuinfo | grep 'name'| uniq | awk -F': ' '{print $2}' )


echo    "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo -e "CPU Usage Percentage : \e[31m$CPU\e[0m"
echo -e "CPU Model : \e[31m$CPU_model\e[0m"
echo    "__________________________________________"
