#!/bin/bash

# Configuration
BACKUP_DIR="/home/ubuntu/backups"
API_DIR="/home/ubuntu/student-api"  # Change this to your API directory name
LOG_FILE="/var/log/backup.log"
DB_USER="student"           # Only if using database
DB_PASS="Neema@@24"           # Only if using database
DB_NAME="student_db"               # Only if using database

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Timestamp for logging
echo "=== Backup started at $(date) ===" >> "$LOG_FILE"

# 1. Backup API files
API_BACKUP_FILE="$BACKUP_DIR/api_backup_$(date +%Y-%m-%d).tar.gz"
if tar -czvf "$API_BACKUP_FILE" "$API_DIR" >> "$LOG_FILE" 2>&1; then
    echo "[SUCCESS] API backup created: $API_BACKUP_FILE" >> "$LOG_FILE"
else
    echo "[ERROR] Failed to create API backup" >> "$LOG_FILE"
fi

# 2. Backup database (MySQL example - remove if not using DB)
DB_BACKUP_FILE="$BACKUP_DIR/db_backup_$(date +%Y-%m-%d).sql"
if mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$DB_BACKUP_FILE" 2>> "$LOG_FILE"; then
    echo "[SUCCESS] Database backup created: $DB_BACKUP_FILE" >> "$LOG_FILE"
else
    echo "[ERROR] Database backup failed" >> "$LOG_FILE"
fi

# 3. Cleanup old backups (older than 7 days)
find "$BACKUP_DIR" -type f -mtime +7 -name '*.tar.gz' -delete >> "$LOG_FILE" 2>&1
find "$BACKUP_DIR" -type f -mtime +7 -name '*.sql' -delete >> "$LOG_FILE" 2>&1
echo "Deleted backups older than 7 days" >> "$LOG_FILE"

echo "=== Backup completed at $(date) ===" >> "$LOG_FILE"
