# CS 421 - Assignment 2: Automated Server Management

**Server IP:** [54.152.132.206](http://54.152.132.206)  
**Instructor:** Dr. Goodiel C. Moshi  
**Submission Email:** [goodiel.moshi@udom.ac.tz](mailto:goodiel.moshi@udom.ac.tz)  
**Due Date:** 19th April 2025 (1800 hrs)

---

## installation
** git
**cd bash_scripts

---

### scripts 
```bash
chmod +x bash_scripts/*.sh

# Run health check
sudo bash_scripts/health_check.sh

# Perform initial backup
sudo bash_scripts/backup_api.sh

# Update server (if needed)
sudo bash_scripts/update_server.sh

---
