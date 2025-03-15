# Sisop-1-2025-IT10

## Member

1. Ardhi Putra Pradana (5027241022)
2. Aslam Ahmad Usman (5027241074)
3. Kanafira Vanesha Putri (5027241010)

## Reporting

### Soal 1

Pada soal nomer 1 diminta untuk menampilkan data 
1. Chris Hemsworth membaca
2. Rata-rata durasi membaca dengan Tablet
3. Pembaca dengan rating tertinggi
4. Genre paling populer di Asia setelah 2023

Sehingga penyelesaian pada nomor 1 adalah berikut ini

A) Pada soal ini diminta untuk menghitung jumlah baris di tablet ajaib yang menunjukkan buku-buku yang dibaca oleh Chris Hemsworth.
```
if [ "$pilihan" == "1" ]; then
awk -F ',' 'NR > 1 && $2 == "Chris Hemsworth" {++n}
END { print "Chris Hemsworth membaca", n, "buku." }' reading_data.csv
```

B) Pada soal ini diminta untuk menghitung rata-rata durasi membaca untuk buku-buku yang dibaca menggunakan Tablet
```
elif [ "$pilihan" == "2" ]; then
awk -F ',' 'NR > 1 && $8 == "Tablet" { sum += $6; count++ }
END { print "Rata-rata durasi membaca dengan Tablet adalah", sum/count, "menit." }' reading_data.csv
```

C) Pada soal ini diminta untuk mencari siapa yang memberikan rating tertinggi untuk buku yang dibaca beserta nama dan judul bukunya 
```
elif [ "$pilihan" == "3" ]; then
awk -F ',' 'NR > 1 && $7 > max { max = $7; name =  $2; book = $3 }
END { print "Pembaca dengan rating tertinggi: "name, "-", book, "-", max }' reading_data.csv
```

D) Pada soal ini diminta untuk menganalisis data untuk menemukan genre yang paling sering dibaca di Asia setelah 31 Desember 2023, beserta jumlahnya
```
elif [ "$pilihan" == "4" ]; then
awk -F ',' 'NR > 1 && $9 == "Asia" && $5 > "2023-12-31" { genres[$4]++ }
END {max = 0; for (genre in genres) {if (genres[genre] > max) {max = genres[genre];most_common = genre;}} print "Genre paling populer di Asia setelah 2023 adalah " most_common " dengan " max " buku."}' reading_data.cs
```

### Soal 2

Dalam soal 2 terdapat 9 hal yang harus kita lakukan:
1. “First Step in a New World”
2. “Radiant Genesis”
3. “Unceasing Spirit”
4. “The Eternal Realm of Light”
5. “The Brutality of Glass”
6. “In Grief and Great Delight”
7. “On Fate's Approach”
8. “The Disfigured Flow of Time”
9. “Irruption of New Color”

Semua program di soal ini berawal dari terminal.sh.

1. “First Step in a New World”
   
Soal ini mengharuskan untuk membuat register.sh dan login.sh dengan parameter berupa email, username, dan password. Lalu hasil dari input dimasukkan ke dalam Database yang berisikan data-data player.
```
DATABASE="data/player.csv"

read -p "Enter Email Address: " email
read -p "Enter Username: " username
read -sp "Enter Password: " password

echo "$email,$username,$password_hash" >> "$Database"
```

Sementara parameter untuk login.sh hanya berupa email dan password.

```
Database="data/player.csv"

read -p "Enter your email: " email
read -sp "Enter your password: " password
```


2. “Radiant Genesis”
   
Disini kita harus menambahkan constraint pada email dan password. Hal ini bisa dilakukan dengan if statement:
```
function email_constraint()
{
 if [[ ! "$1" =~ @.*\. ]]; then
    echo "Invalid Email Format"
    exit 1
 fi
}

function password_constraint()
{
 if [[ ! "$1" =~ [A-Z] || ! "$1" =~ [a-z] || ! "$1" =~ [0-9] || ${#1} -lt 8 ]]; then
   echo "Invalid Password Format"
   exit 1
 else 
   echo "Password meets all requirement"
 fi
}
```
Setelah itu fungsi bisa dipanggil:
```
read -p "Enter Email Address: " email
email_constraint "$email"

read -sp "Enter Password: " password
password_constraint ".$password"
```
Jika salah satu requirement tidak terpenuhi, maka program akan mengeluarkan pesan:
```
Enter Email Address: inites1gmail.com
Invalid Email Format
```
dan program akan langsung kembali ke terminal.sh.


3. “Unceasing Spirit”
   
Pada soal ini kita harus mencegah duplikasi player dengan membuat email yang hanya bisa dipakai sekali pada saat registrasi. Hal ini bisa dilakukan dengan menggunakan grep:
```
if grep -q "$email," "$Database"; then
    echo "Email is already registered"
    exit 1
fi
```
Jika email yang dimasukan ternyata sudah terdapat dalam Database, maka program akan mengeluarkan pesan dan keluar dari program:
```
Enter Email Address: inites1@gmail.com
Email is already registered
```


4. “The Eternal Realm of Light"
   
Selanjutnya, password yang dimasukan pada saat registrasi harus diubah dengan algoritma hashing sha256sum. Program dibawah ini kita implementasikan dalam register.sh serta login.sh untuk menjaga konsistensi program:
```
password_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')
```
Jangan lupa meng-update redirect password ke Database-nya:
```
echo "$email,$username,$password_hash" >> "$DATABASE"
```


5. “The Brutality of Glass"
   
Di soal ini diminta untuk melacak presentase penggunaan CPU dan model CPU dari device yang dipakai player.
```
CPU_model=$( cat /proc/cpuinfo | grep 'name'| uniq | awk -F': ' '{print $2}' )
CPU_usage=$( top -bn2 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}' | awk 'NR==2 {print $0}' )
```
Berikut contoh outputnya:
```
CPU Usage Percentage : 1.5751%%
CPU Model : 11th Gen Intel(R) Core(TM) i5-1155G7 @ 2.50GHz
```


6. “In Grief and Great Delight”
   
Kita juga harus melacak penggunaan RAM dan memastikan bahwa hasilnya memiliki output yang sama dengan package resource checker.
```
Fragment Usage=$( free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2}' )
Available=$( free -m | awk '/Mem:/ {print $7}' )
cache=$( free -m | awk '/Mem:/ {print $6}' )
Total=$( free -m | awk '/Mem:/ {print $2}' )
```


7. “On Fate's Approach”
   
Pada soal ini membuat Crontab manager dengan pilihan untuk menambah/menghapus CPU/RAM usage serta melihat seluruh job monitoring:
```
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "===================ARCAEA TERMINAL==================="
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
echo "  ID  |  OPTION"
echo "_____________________________________________________"
echo ""
echo "  1   |  Add CPU - Core Monitor to Crontab"
echo "  2   |  Add RAM - Fragement Monitor to Crontab"
echo "  3   |  Remove CPU - Core Monitor from Crontab"
echo "  4   |  Remove RAM - Fragement Monitor From Crontab"
echo "  5   |  View All Scheduled Monitoring Job"
echo "  6   |  Exit Arcaea Terminal"
echo ""
echo "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
```

8. “The Disfigured Flow of Time”

9. “Irruption of New Color”
Di soal ini diharuskan untuk membuat interface yang menggabungkan setiap komponen dan menjadi titik masuk bagi para player.

Pertama-tama player akan bermula di terminal.sh, dimana player dapat melakukan registrasi dan login.
```
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
==========ARCAEA TERMINAL==========

‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
  ID  |  OPTION
___________________________________

  1   |  Register New Account
  2   |  Login to Existing Account
  3   |  Exit Arcaea Terminal

‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
Option:
```
Setelah player selesai login, player mendapatkan akses untuk menuju crontab_manager.sh. Contoh saat player berhasil login:
```
Signed as Arima Kana
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
===================ARCAEA TERMINAL===================

‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
  ID  |  OPTION
_____________________________________________________

  1   |  Add CPU - Core Monitor to Crontab
  2   |  Add RAM - Fragement Monitor to Crontab
  3   |  Remove CPU - Core Monitor from Crontab
  4   |  Remove RAM - Fragement Monitor From Crontab
  5   |  View All Scheduled Monitoring Job
  0   |  Exit Arcaea Terminal

‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
Option:
```


### Soal 3

Dalam soal nomer 3 akan ada 5 hal yang perlu dilakukan yaitu

1. Membuat fetching API
2. Membuat progress bar
3. Membuat tampilan waktu
4. Membuat tampilan custom cmatrix
5. Membuat tampilan custom process list

Untuk bisa melakukan pemilihan hal - hal program harus menerima sebuah named options `--play`, berikut adalah script untuk melakukan parsing args tersebut

```sh
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
```

script tersebut akan memproses dan mendeteksi bahwa program shell yang dijalankan memiliki argument dan argument yang valid adalah `--play` dengan syntax yang valid bisa seperti `--play <tracker>` atau `--play=<tracker>`. Memanfaatkan command `getopt` untuk melakukan parsing named options nya. Dan lalu melakukan execute  dan memasukkan ke `while` melakukan assign dan memvalidasi option yang sesuai.

Selanjutnya adalah membuat setiap objektif fungsionalitas yang ada menjadi terpecah kedalam sebuah `function` untuk mempermudah dan memaksimalkan readability.

1. Function api call

```sh
# -- FUNCTION API CALL --
function handle_speak {
    clear
    figlet "Affirmation" 
    local emojis=(💡 🔥 ✨ 🎉 🔮 🗿)

    while true; do
        local selected=${emojis[$RANDOM % ${#emojis[@]}]};
        local result=$(curl -H "Content-Type: application/json" "https://www.affirmations.dev" 2>/dev/null)
        local affirmation=$(echo $result | awk -F '"' '{print $4}')
        echo -n "[$selected] "
        for ((i=0; i<${#affirmation}; i++)); do
            echo -n "${affirmation:$i:1}"
            sleep 0.05  # Adjust typing speed here
        done
        echo ""
        sleep 1
    done
}
```

Function ini ditujukan untuk menjadi handle melakukan fetching ke API yang isinya adalah sebuah afirmasi. Menggunakan `curl` untuk melakukan fetching, kemudian memparsing data menggunakan `awk` untuk mendapatkan teks yang sesuai, karena default outputnya adalah `json`. Kemudian membuat estetika dengan menampilkan random `emoji` dan juga membuat seolah - olah typed animation dengan cara melakukan *char-per-char* output menggunakan `for loop` untuk masing - masing karakternya.

2. Function progress bar

```sh
# -- FUNCTION PROGRESS BAR --
function progress_bar {
    local width=100
    local spinner="/-\|"
    local total_time=0
    for((progress = 0; progress <= 100; progress+=1)); do
        clear
        local filled=$(( progress * width / 100 ))
        local empty=$(( width - filled ))
        local spin_char="${spinner:progress%4:1}"
        local sleepness=$(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
        
        local bar_filled=$(printf "%0.s " $(seq 1 $filled))
        local bar_empty=$(printf "%0.s " $(seq 1 $empty))
        if [ $progress -eq 100 ]; then
            bar_empty=""
        fi

        printf "\e[33m%s\e[0m \e[42m%s\e[0m\e[107m%s\e[0m \e[32m%d%%\e[0m" "$spin_char" "$bar_filled" "$bar_empty" "$progress"
        printf "\nTotal time elapsed: %f seconds\n" $total_time
        total_time=$(echo "$total_time + $sleepness" | bc)
        sleep $sleepness
    done
    echo 
}
```

Untuk membuat progress bar ini pertama menentukan static width nya kemudian melakukan kalkulasi ke dalam `for loop` dengan range `0-100` dan kemudian didalamnya melakukan kalkulasi terhadap bagian yang terisi dan bagian yang belum terisi, nah kemudian melakukan randomize sleeptime nya menggunakan `awk` script. Kemudian untuk menampilkan bar nya disini menggunakan teknik `bash coloring` dimana untuk bar yang terisi menggunakan background color warna hijau `\e[42m` dan untuk yang masih kosong menggunakan background color warna putih `\e[107m`. Dan beberapa hal lainnya seperti animation spinner untuk menambah estetika yaitu dengan mengambil urutan sesuai next progress nya, karena ada 4 char spinner maka untuk setiap progress nya dimodulus `4` untuk mendapatkan indexnya.

3. Function show time

```sh
# -- FUNCTION SHOW TIME --
function show_time {
    while true; do
        clear
        local part1=$(TZ="Asia/Jakarta" date +"%H:%M:%S")
        local part2=$(TZ="Asia/Jakarta" date +"%A %B %d, %Y %Z (Asia/Jakarta)")
        echo -e "$part2"
        
        echo -en "\e[36m"
        echo -en "$part1" | figlet -f lean
        echo -en "\e[0m"
        sleep 1
    done
}
```

Disini cukup simple, yaitu dengan melakukan parsing menggunakan command `date` lalu melakukan formatting sesuai format yang akan ditampilkan, make sure disini melakukan set timezone ke `Asia/Jakarta` sesuai dengan timezone lokasi saat ini. Membagi menjadi 2 part, part 1 menampilkan exact time nya,dan part 2 menampilkan informasi detail seperti tanggal, bulan, tahun dan timezone nya. Kemudian untuk estetika disini menggunakan `figlet` untuk bisa menampilkan tampilan jam seolah - olah jam `digital` pada terminal, dan sisanya adalah melakukan bash coloring, dan menggunakan `while` dengan `sleep` 1 detik untuk program bisa berjalan terus.

4. Function money cmatrix

```sh
# -- FUNCTION MONEY CMATRIX -- 
money_cmatrix() {
    clear
    local symbols=('$' '€' '£' '¥' '¢' '₹' '₩' '₿' '₣')
    local colors=('\e[31m' '\e[32m' '\e[33m' '\e[34m' '\e[35m' '\e[36m')
    local rows=$(tput lines)  
    local cols=$(tput cols)

    local i=0
    while true; do
        local rand_row=$(( RANDOM % rows + 1 ))  
        local rand_col=$(( RANDOM % cols + 1 ))  
        local rand_color="${colors[RANDOM % ${#colors[@]}]}"
        local symbol="${symbols[RANDOM % ${#symbols[@]}]}" 
        printf "\033[%d;%dH${rand_color}%s\e[0m" "$rand_row" "$rand_col" "$symbol"
        if [ $((i % 2)) -eq 0 ]; then
            printf "\033[%dH%s\e[0m\n" "$rand_col" ""
        fi 
        sleep 0.03
        i=$((i+1))
    done
}
```

Untuk money cmatrix, disini melakukan define variable seperti symbols, colors, rows (max height), dan col (max width) menggunakan `tput`.
Lalu selanjutnya menggunakan `while` dengan `sleep` 0.03 detik agar program terus berjalan, lalu kemudian menentukan random order dari row dan col nya, dan menentukan random symbol dan juga colornya. Nah kemudian memasukkan kedalam printf dengan beberapa parameter untuk melakukan positionig dan juga menampilkan symbolnya, lalu kemudian ada bagian `\033[` dimana ini digunakan untuk `preserving cursor` karena cursor nya akan terus berpindah posisi, sehingga ini digunakan untuk mengkontrol posisi cursor tersebut  lalu bagian ini `%d;%dH` untuk menghandle parameter random col dan row nya, sisanya `${rand_color}` hanya untuk menampilkan color dan args terakhir `%s` sebagai parameter dari symbolnya. Lalu untuk melakukan `preserving scroll` nya disini ada tambahan command yang akan dilakukan setelah `2 kali iterasi` sehingga seolah - olah symbol - symbol tersebut terus bergerak keatas.

5. Function show process

```sh
# -- FUNCTION SHOW PROCESS --
function show_process {
    while true; do
        clear
        echo -en "\e[32m"
        printf -- '-%.0s' {1..40}; printf " System Info "; printf -- '-%.0s' {1..40}; echo
        echo "Time: $(date)"
        echo "Uptime: $(uptime -p)"
        echo "Hostname: $(hostname)"
        echo -en "\e[33m"
        printf -- '-%.0s' {1..41}; printf " CPU Usage "; printf -- '-%.0s' {1..41}; echo
        awk '{if($1=="cpu") printf "User: %.2f%%, System: %.2f%%, Idle: %.2f%%\n", $2*100/($2+$4+$5), $4*100/($2+$4+$5), $5*100/($2+$4+$5)}' /proc/stat
        echo -en "\e[34m"
        printf -- '-%.0s' {1..39}; printf " Memory Usage "; printf -- '-%.0s' {1..40}; echo
        free -h
        echo -en "\e[35m"
        printf -- '-%.0s' {1..38}; printf " Top 10 Processes "; printf -- '-%.0s' {1..37}; echo
        ps -eo pid,user,command,time,%cpu,%mem, --sort=-%cpu | head -10
        sleep 1
    done
}
```

Objektif nya adalah untuk membuat customize program seperti `top, htop, etc`, ide nya disini adalah dengan menggunakan beberapa builitin program dan filesystem yang sudah mengatur hal tersebut. Ada 4 bagian yang ditampilkan, system info, cpu usage, memory usage, dan top process yang berjalan berdasarkan cpu. Untuk system info menampilkan beberapa hal menggunakan `date, uptime, hostname` untuk basic info saja. Lalu untuk CPU usage disini memanfaatkan `awk` untuk bisa memparsing filesystem `/proc/stat` untuk membaca bagian cpu yang kemudian dijadikan sebagai input atau argument dari awk tersebut. Lalu untuk memory usage menggunakan command `free`. Dan terakhir untuk top process menggunakan command `ps` dan mengambil top 10 process berdasarkan cpu menggunakan `head`. Lalu semuanya itu dimasukkan kedalam `while` yang kemudian diberikan `sleep` selama 1 detik.

Oke setelah semua hal tersebut selesai, maka langkah selanjutnya adalah melakukan parsing argument yang sesuai tersebut, menggunakan `case` statement.

```sh
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
```

Dan itu adalah step - step yang digunakan, untuk full script nya dapat dilihat pada file [dsotm.h](./soal_3/dsotm.sh)

### Soal 4

Pada soal ini terdapat 6 perintah yakni

1. Menampilkan Usage% dan RawUsage
2. Mengurutkan berdasarkan kolom yang diminta
3. Mencari nama Pokemon tertentu
4. Mencari Pokemon berdasarkan fitur nama dan type
5. Mengecek semua kesalahan pengguna dan dapat memberikan penejelasan pada setiap kasus
6. Membuat help screen

Sehingga penyelesaian pada nomor 4 adalah berikut ini

A)  Menampilkan Usage% tertinggi dan RawUsage tertinggi
```
#Usage% tertinggi
awk -F ',' 'NR > 1 { if ($2+0 > max) { max=$2+0; name=$1 }}
END { print "Highest Adjusted Usage:", name, "with", max "%" }' pokemon_usage.csv
#RawUsage tertinggi
awk -F ',' 'NR > 1 { if ($3+0 > max) { max=$3+0; name=$1 }}
END { print "Highest Raw Usage:", name, "with", max, "uses" }' pokemon_usage.csv
```

B) Mengurutkan berdasarkan kolom yang diminta
```

```

C) Mencari nama Pokemon tertentu
```

```

D) Mencari Pokemon berdasarkan fitur nama dan type
```

```

E) Mengecek semua kesalahan pengguna dan dapat memberikan penejelasan pada setiap kasus
```

```

F) Membuat help screen
```

```
