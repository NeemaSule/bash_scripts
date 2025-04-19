#!/bin/bash
log_file="/var/log/server_health.log"
echo "$(date) - Starting health check..." >> $log_file

# CPU/Memory/Disk checks
cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
mem=$(free -m | awk '/Mem:/ {print $3/$2 * 100}')
disk=$(df -h / | awk '/\// {print $5}' | tr -d '%')

echo "$(date) - CPU: ${cpu}% | Memory: ${mem}% | Disk: ${disk}%" >> $log_file

# Web server check
if ! systemctl is-active --quiet nginx; then
    echo "$(date) - WARNING: Nginx is not running!" >> $log_file
fi

# API endpoint checks
endpoints=("/students" "/subjects")
for endpoint in "${endpoints[@]}"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost$endpoint")
    if [ "$status" -ne 200 ]; then
        echo "$(date) - WARNING: $endpoint returned HTTP $status" >> $log_file
    fi
done
