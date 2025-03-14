#!/bin/sh

DIR=$(realpath $(dirname $0))
BASE_DIR=$(realpath "$DIR/../logs")

if [ ! -d "$BASE_DIR" ]; then
    mkdir -p "$BASE_DIR"
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')] - Core Usage [$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')] - Terminal Model [$(lscpu | grep 'Model name' | awk '{print substr($0, index($0, $3))}')]" >> "$BASE_DIR/../logs/core.log"
