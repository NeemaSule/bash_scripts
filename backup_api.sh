#!/bin/bash
backup_dir="/home/ubuntu/backups"
log_file="/var/log/backup.log"
mkdir -p $backup_dir

echo "$(date) - Starting backup..." >> $log_file

# Backup API files
tar -czvf "$backup_dir/api_backup_$(date +%F).tar.gz" /var/www/student_api && \
    echo "$(date) - API backup successful" >> $log_file || \
    echo "$(date) - ERROR: API backup failed" >> $log_file

# Backup database (example for MySQL)
mysqldump -u student -p'Neema@@24' student_db > "$backup_dir/db_backup_$(date +%F).sql" && \
    echo "$(date) - Database backup successful" >> $log_file || \
    echo "$(date) - ERROR: Database backup failed" >> $log_file

# Cleanup old backups
find $backup_dir -type f -mtime +7 -delete && \
    echo "$(date) - Cleaned up backups older than 7 days" >> $log_file
