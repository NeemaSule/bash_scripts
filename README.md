# Server Automation Scripts - CS 421 Assignment 2

**Server IP:** [54.152.132.206](http://54.152.132.206)  
**Due Date:** April 19, 2025 @ 1800hrs  

---

## 📋 Quick Start
1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/cs421-assignment2.git
   cd cs421-assignment2

   ---
## Make scripts executable:

```bash
chmod +x bash_scripts/*.sh
Schedule automated runs:

```bash
(crontab -l ; echo "0 */6 * * * $(pwd)/bash_scripts/health_check.sh") | crontab -

---
## 📂 Scripts

***🔍 Health Check (health_check.sh)
What it does: Checks server health and API status

Runs every: 6 hours

Logs to: /var/log/server_health.log
---

***💾 Backup Script (backup_api.sh)
What it does: Backs up API files and database

Runs every: Day at 2 AM

Keeps backups for: 7 days

🔄 Update Script (update_server.sh)
What it does: Updates server and API

Runs every: 3 days at 3 AM

⚙️ Setup
Requirements
bash
sudo apt update && sudo apt install -y curl git
How to Use Each Script
Health Check:

bash
sudo ./bash_scripts/health_check.sh
Backup:

bash
sudo ./bash_scripts/backup_api.sh
Update:

bash
sudo ./bash_scripts/update_server.sh
📝 Backup Methods
Full Backup

Simple but uses more space

Incremental Backup

Saves space but harder to restore

Differential Backup

Balance between space and restore ease

✅ How to Check Everything is Working
bash
# View health logs:
tail -n 5 /var/log/server_health.log

# Test API:
curl -I http://54.152.132.206/students
