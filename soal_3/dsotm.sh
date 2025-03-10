#!/bin/bash

# -- MEMPROSES DAN MENGAMBIL ARGUMENT DATA --
if [ "$#" -eq 0 ]; then
  echo 'Usage: dsotm.sh --play="<tracker>"'
  exit 1
fi

VALID_ARGS=$(getopt -o '' -l play: -- "$@") || exit 1
eval set -- "$VALID_ARGS"

while true; do
  case "$1" in
    --play)
        play="$2"
        shift 2
        ;;
    --) shift; 
        break 
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
  esac
done

# -- FUNCTION API CALL --
function handle_speak {
    while true; do
        local result=$(curl -H "Content-Type: application/json" "https://www.affirmations.dev" 2>/dev/null)
        echo $result | awk -F '"' '{print $4}'
        sleep 1
    done
}

# -- FUNCTION PROGRESS BAR --
function progress_bar {
    local width=100
    local spinner="/-\|"
    for((progress = 0; progress <= 100; progress+=1)); do
        local filled=$(( progress * width / 100 ))
        local empty=$(( width - filled ))
        local spin_char="${spinner:progress%4:1}"

        local bar_filled=$(printf "%0.s#" $(seq 1 $filled))
        local bar_empty=$(printf "%0.s " $(seq 1 $empty))

        printf "\r%s [%s%s] %d%% " "$spin_char" "$bar_filled" "$bar_empty" "$progress"
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
    done
    echo 
}

# -- FUNCTION SHOW TIME --
function show_time {
    while true;do
        local current=$(date +"%Y-%m-%d %H:%M:%S")
        printf "\r%s" "$current"
        sleep 1
    done
}

# -- FUNCTION MONEY CMATRIX -- 
money_cmatrix() {
    local symbols=('$' '€' '£' '¥' '¢' '₹' '₩' '₿' '₣')
    local rows=$(tput lines)  
    local cols=$(tput cols)

    while true; do
        local rand_row=$(( RANDOM % rows + 1 ))  
        local rand_col=$(( RANDOM % cols + 1 ))  
        local symbol="${symbols[RANDOM % ${#symbols[@]}]}" 
        printf "\n\033[%d;%dH%s\n" "$rand_row" "$rand_col" "$symbol"
        sleep 0.05
    done
}

# -- FUNCTION SHOW PROCESS --
function show_process {
    top
}

# -- MEMPROSES PILIHAN -- 
case $play in
    "Speak to Me")
        handle_speak
        ;;
    "On the Run")
        progress_bar
        ;;
    "Time")
        show_time
        ;;
    "Money")
        money_cmatrix
        ;;
    "Brain Damage")
        show_process
        ;;
    *)
        echo "Invalid"
        ;;
esac
