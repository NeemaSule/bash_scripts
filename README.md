[healh-check-log.txt](https://github.com/user-attachments/files/19819921/healh-check-log.txt)[health-log.txt](https://github.com/user-attachments/files/19819913/health-log.txt)[health-log.txt](https://github.com/user-attachments/files/19819909/health-log.txt)[health-log.txt](https://github.com/user-attachments/files/19819907/health-log.txt)[health-log.txt](https://github.com/user-attachments/files/19819874/health-log.txt)[health-log.txt](https://github.com/user-attachments/files/19819872/health-log.txt)[health-log.txt](https://github.com/user-attachments/files/19819863/health-log.txt)[backup-log.txt](https://github.com/user-attachments/files/19819841/backup-log.txt)[health-log.txt](https://github.com/user-attachments/files/19819818/health-log.txt)# CS 421 - Assignment 2: Automated Server Management

**Server IP:** [54.152.132.206](http://54.152.132.206)  
**Instructor:** Dr. Goodiel C. Moshi  
**Submission Email:** [goodiel.moshi@udom.ac.tz](mailto:goodiel.moshi@udom.ac.tz)  
**Due Date:** 19th April 2025 (1800 hrs)

---
## Scripts Overview
#### 1. health_check.sh
Purpose: Monitors server resources (CPU, memory, disk) and checks API endpoint availability.
Logs: /var/log/server_health.log
Cron Schedule: Every 6 hours (0 */6 * * *)

#### 2. backup_api.sh
a. **Full Backup**  
   - **Execution**: `tar -czvf backup.tar.gz /path/to/data`  
   - **Pros**: Easy restoration.  
   - **Cons**: High storage usage.  
b. **Incremental Backup**  
   - **Execution**: Uses `rsync --link-dest` to backup only changes since the last backup.  
   - **Pros**: Saves storage.  
   - **Cons**: Slower restoration (requires full + all incrementals).  
c. **Differential Backup**  
   - **Execution**: Backs up changes since the last full backup.  
   - **Pros**: Faster restoration than incremental.  
   - **Cons**: More storage than incremental.

#### 3. update_server.sh
Purpose: Automate server/API updates.

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
```
---

### Schedule Automated Execution(contrib)
```bash
#!/bin/bash
# Cron Setup Script

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
```
---

### Run contrib
```bash
#Save the above as setup_cron.sh

#Make executable:
chmod +x setup_cron.sh

#Run without sudo:
 ./setup_cron.sh

#check contrib status with
crontab -l
```
---
![contrib in action](https://github.com/user-attachments/assets/085a06dd-e0fc-4b87-b488-e0c2c2631eff)

### Script Logs
#### health check log
[healh-check-log.txt](https://github.com/user-attachments/files/19819939/healh-check-log.txt)

#### update log
[update-log.txt](https://github.com/user-attachments/files/19819825/update-log.txt)

#### backup log
[backup-log.txt](https://github.com/user-attachments/files/19819859/backup-log.txt)




