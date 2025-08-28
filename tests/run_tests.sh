#!/usr/bin/env bash
set -euo pipefail

if [ -f main.py ]; then
  OUT=$(python3 main.py)
elif [ -f main.js ]; then
  OUT=$(node main.js)
elif [ -f Main.java ] || [ -f main.java ]; then
  javac Main.java || javac main.java
  OUT=$(java Main || java main)
elif [ -f main.c ]; then
  gcc -O2 -std=c11 main.c -o main
  OUT=$(./main)
else
  echo "Tidak ditemukan berkas program yang didukung (main.py/js/java/c)." >&2
  exit 1
fi

echo "$OUT" | grep -Eiq "^nama:\s*[^[:space:]]" \
  || { echo "Output 'Nama:' tidak ditemukan / kosong"; exit 1; }
echo "$OUT" | grep -Eiq "^bahasa favorit:\s*[^[:space:]]" \
  || { echo "Output 'Bahasa favorit:' tidak ditemukan / kosong"; exit 1; }

echo "LULUS: format output benar"
