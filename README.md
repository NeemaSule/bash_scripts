# CS 421 - Assignment 2: Automated Server Management

**Server IP:** [54.152.132.206](http://54.152.132.206)  
**Instructor:** Dr. Goodiel C. Moshi  
**Submission Email:** [goodiel.moshi@udom.ac.tz](mailto:goodiel.moshi@udom.ac.tz)  
**Due Date:** 19th April 2025 (1800 hrs)

---

## installation
** (https://github.com/NeemaSule/bash_scripts.git)
---

### scripts 
```bash

#adding excution permissions to all scripts
chmod +x bash_scripts/*.sh

# Run health check
sudo bash_scripts/health_check.sh

# Perform initial backup
sudo bash_scripts/backup_api.sh

# Update server (if needed)
sudo bash_scripts/update_server.sh

---
### Schedule Automated Execution(contrib)
```bash
#!/bin/bash
# Universal Cron Setup Script

# Configuration
SCRIPTS_DIR="/home/ubuntu/bash_scripts"
LOG_DIR="/var/log"
CURRENT_USER=$(whoami)

echo "Setting up cron jobs for user: $CURRENT_USER"

# Verify scripts exist
for script in health_check.sh backup_api.sh update_server.sh; do
    if [ ! -f "$SCRIPTS_DIR/$script" ]; then
        echo "Error: Missing $SCRIPTS_DIR/$script"
        exit 1
    done
done

# Set up cron jobs
(
    echo "# CS421 Assignment 2 Cron Jobs"
    echo "0 */6 * * * $SCRIPTS_DIR/health_check.sh >> $LOG_DIR/server_health.log 2>&1"
    echo "0 2 * * * $SCRIPTS_DIR/backup_api.sh >> $LOG_DIR/backup.log 2>&1"
    echo "0 3 */3 * * $SCRIPTS_DIR/update_server.sh >> $LOG_DIR/update.log 2>&1"
) | crontab -

echo -e "\nCurrent cron jobs:"
crontab -l

---
