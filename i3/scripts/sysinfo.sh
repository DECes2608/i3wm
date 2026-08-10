#!/bin/sh

# RAM kullanımı
ram=$(free -h --si | awk '/^Mem:/ {print $3" / "$2}')
ram_percent=$(free | awk '/^Mem:/ {printf "%.0f", $3/$2 * 100}')

# CPU Sıcaklığı (coretemp - i7-7500U için Package id 0 genelde ilk değer)
cpu_temp=$(sensors 2>/dev/null | awk '/Package id 0:/ {print $4}' | tr -d '+')
if [ -z "$cpu_temp" ]; then
    cpu_temp=$(sensors 2>/dev/null | awk '/^Core 0:/ {print $3}' | tr -d '+')
fi

# GPU Kullanımı (Nvidia 940MX - Optimus'ta kart boştaysa nvidia-smi çıktı vermeyebilir)
if command -v nvidia-smi >/dev/null 2>&1; then
    gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)
    if [ -n "$gpu_util" ]; then
        gpu_line="GPU: ${gpu_util}%"
    else
        gpu_line="GPU: kapalı/boşta"
    fi
else
    gpu_line="GPU: nvidia-smi yok"
fi

notify-send -u low -t 4000 "Sistem Durumu" \
"RAM: ${ram} (%${ram_percent})
CPU: ${cpu_temp:-N/A}
${gpu_line}"
