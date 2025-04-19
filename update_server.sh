#!/bin/bash
log_file="/var/log/update.log"
api_dir="/var/www/student_api"

echo "$(date) - Starting update..." >> $log_file

# Update packages
apt update && apt upgrade -y && \
    echo "$(date) - Packages updated" >> $log_file || \
    echo "$(date) - ERROR: Package update failed" >> $log_file

# Pull latest API code
cd $api_dir
git pull && \
    echo "$(date) - GitHub repo updated" >> $log_file || \
    { echo "$(date) - ERROR: git pull failed" >> $log_file; exit 1; }

# Restart web server
systemctl restart nginx && \
    echo "$(date) - Nginx restarted" >> $log_file
