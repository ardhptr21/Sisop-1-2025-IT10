#!/bin/bash

DATA="pokemon_usage.csv"

# -- pengerjaan soal A --
#Usage% tertinggi
awk -F ',' 'NR > 1 { if ($2+0 > max) { max=$2+0; name=$1 }}
END { print "Highest Adjusted Usage:", name, "with", max "%" }' pokemon_usage.csv
#RawUsage tertinggi
awk -F ',' 'NR > 1 { if ($3+0 > max) { max=$3+0; name=$1 }}
END { print "Highest Raw Usage:", name, "with", max, "uses" }' pokemon_usage.csv

