# CS 421 - Assignment 2: Server Automation Scripts

**Server IP:** [54.152.132.206](http://54.152.132.206)  
**Instructor:** Dr. Goodiel C. Moshi  
**Submission Email:** [goodiel.moshi@udom.ac.tz](mailto:goodiel.moshi@udom.ac.tz)  
**Due:** 19th April 2025 (1800 hrs)

---

## 📌 Table of Contents
1. [Repository Structure](#-repository-structure)
2. [Scripts Overview](#-scripts-overview)
3. [Setup Instructions](#%EF%B8%8F-setup-instructions)
4. [Backup Schemes](#-backup-schemes)
5. [Verification](#-verification)
6. [Submission](#-submission)
7. [Notes](#%EF%B8%8F-notes)

---

## 📁 Repository Structure
.
├── bash_scripts/
│ ├── health_check.sh # Server health monitoring
│ ├── backup_api.sh # Automated backups
│ └── update_server.sh # System updates
├── logs_sample.txt # Log excerpts
├── cron_setup.png # Cron job proof
└── README.md # This documentation


---

## 🛠️ Scripts Overview

### 1. `health_check.sh`
**Purpose**: Monitor CPU/memory/disk and API endpoints.  
**Logs**: `/var/log/server_health.log`  
**Cron**: `0 */6 * * *` (Every 6 hours)

```bash
#!/bin/bash
log_file="/var/log/server_health.log"
echo "$(date) - Starting checks..." >> $log_file

# Resource checks
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "$(date) - CPU: $cpu%" >> $log_file

# API test
curl -s http://54.152.132.206/students | grep -q "200" || echo "$(date) - API DOWN" >> $log_file
2. backup_api.sh
Purpose: Backup API files + DB with 7-day retention.
Logs: /var/log/backup.log
Cron: 0 2 * * * (Daily at 2 AM)

bash
#!/bin/bash
backup_dir="/home/ubuntu/backups"
mkdir -p $backup_dir

# Compress API files
tar -czvf "$backup_dir/api_$(date +%F).tar.gz" /var/www/api >> /var/log/backup.log 2>&1

# Cleanup old backups
find $backup_dir -type f -mtime +7 -delete
3. update_server.sh
Purpose: Update packages + deploy API changes.
Logs: /var/log/update.log
Cron: 0 3 */3 * * (Every 3 days at 3 AM)

bash
#!/bin/bash
{
  apt update && apt upgrade -y
  cd /var/www/api && git pull
  systemctl restart nginx
} >> /var/log/update.log 2>&1
⚙️ Setup Instructions
Prerequisites
bash
sudo apt update && sudo apt install -y curl git mysql-client
Deployment
Clone repo:

bash
git clone https://github.com/your-username/cs421-assignment2.git
Make scripts executable:

bash
chmod +x bash_scripts/*.sh
Schedule cron jobs:

bash
(crontab -l ; echo "0 */6 * * * $(pwd)/health_check.sh") | crontab -
🔄 Backup Schemes
Type	Command	Pros	Cons
Full	tar -czvf backup.tar.gz /data	Easy restoration	High storage
Incremental	rsync -a --link-dest=last/ src/ dst/	Saves space	Complex restoration
Differential	tar -czvf diff.tar.gz -N $(date -d "7 days ago") /data	Balanced	Medium storage
🔍 Verification
bash
# Check logs
tail -f /var/log/server_health.log

# Test API
curl -I http://54.152.132.206/students
