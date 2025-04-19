###CS 421 - Assignment 2: Automated Server Management
###Server IP: http://54.152.132.206
###Instructor: Dr. Goodiel C. Moshi


Repository Structure
bash_scripts/
├── health_check.sh       # Monitors server health and API status
├── backup_api.sh         # Backs up API files and database
├── update_server.sh      # Automates server/API updates
README.md                 # Project documentation (this file)

Scripts Overview
1. health_check.sh
Purpose: Monitors server resources (CPU, memory, disk) and checks API endpoint availability.
Logs: /var/log/server_health.log
Cron Schedule: Every 6 hours (0 */6 * * *)

Usage
bash
chmod +x health_check.sh
sudo ./health_check.sh
Checks Performed
CPU/Memory/Disk usage.

Web server (Nginx/Apache) status.

API endpoints (/students, /subjects) HTTP 200 OK.

2. backup_api.sh
Purpose: Backs up API files and database, then purges backups older than 7 days.
Backup Location: /home/ubuntu/backups/
Logs: /var/log/backup.log
Cron Schedule: Daily at 2 AM (0 2 * * *)

Usage
bash
chmod +x backup_api.sh
sudo ./backup_api.sh
Features
Compresses API directory to api_backup_YYYY-MM-DD.tar.gz.

Exports database to db_backup_YYYY-MM-DD.sql (if applicable).

Auto-cleans old backups.

3. update_server.sh
Purpose: Updates server packages and deploys latest API code from GitHub.
Logs: /var/log/update.log
Cron Schedule: Every 3 days at 3 AM (0 3 */3 * *)

Usage
bash
chmod +x update_server.sh
sudo ./update_server.sh
Steps
Runs apt update && apt upgrade -y.

Pulls latest code from Git.

Restarts web server (Nginx/Apache).

Setup Instructions
1. Prerequisites
AWS Ubuntu Server (Free Tier t2.micro/t3.micro).

Installed dependencies:

bash
sudo apt update && sudo apt install -y curl git mysql-client
2. Deploy Scripts
Clone your repository to the server:

bash
git clone https://github.com/your-username/your-repo.git
Navigate to the scripts directory:

bash
cd your-repo/bash_scripts
Make scripts executable:

bash
chmod +x *.sh
3. Schedule with Cron
Edit crontab:

bash
crontab -e
Add these lines:

bash
0 */6 * * * /path/to/health_check.sh
0 2 * * * /path/to/backup_api.sh
0 3 */3 * * /path/to/update_server.sh
Backup Schemes (Task 0)
Three common backup methods are documented in this repository’s README.md, including:

Full Backup

Incremental Backup

Differential Backup

Refer to the file for advantages/disadvantages and execution steps.

Verification
Check Logs:

bash
cat /var/log/server_health.log       # Health checks
cat /var/log/backup.log              # Backup history
cat /var/log/update.log              # Update logs
Test API Endpoints:

bash
curl http://54.152.132.206/students
curl http://54.152.132.206/subjects
