#!/bin/bash

# -- Pengerjaan soal A --
awk -F ',' 'NR > 1 && $2 == "Chris Hemsworth" {++n}
END { print "Chris Hemsworth membaca", n, "buku." }' reading_data.csv

# -- Pengerjaan soal B --
awk -F ',' 'NR > 1 && $8 == "Tablet" { sum += $6; count++ }
END { print "Rata-rata durasi membaca dengan Tablet adalah", sum/count, "menit." }' reading_data.csv

# -- Pengerjaan soal C --
awk -F ',' 'NR > 1 && $7 > max { max = $7; name =  $2; book = $3 }
END { print "Pembaca dengan rating tertinggi: "name, "-", book, "-", max }' reading_data.csv

# -- Pengerjaan soal D --
awk -F ',' 'NR > 1 && $9 == "Asia" && $5 > "2023-12-31" { genres[$4]++ }
END {max = 0; for (genre in genres) {if (genres[genre] > max) {max = genres[genre];most_common = genre;}} print "Genre paling populer di Asia setelah 2023 adalah " most_common " dengan " max " buku."}' reading_data.csv
