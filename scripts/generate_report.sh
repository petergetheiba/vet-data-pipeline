#!/bin/bash
# generate_report.sh - Generates daily summary report

DATE=$(date)
DATESTAMP=$(date +%Y-%m-%d)
REPORT_FILE=~/vet-data-pipeline/reports/daily_summary.txt
LOG_FILE=~/vet-data-pipeline/logs/process_log.txt
BACKUP_DIR=~/vet-data-pipeline/data/patient_backups

echo "Generating daily report..."

# Count animals
TOTAL_DOGS=$(tail -n +2 ~/vet-data-pipeline/patients/dogs.csv | wc -l)
TOTAL_CATS=$(tail -n +2 ~/vet-data-pipeline/patients/cats.csv | wc -l)
TOTAL=$((TOTAL_DOGS + TOTAL_CATS))
HEALTHY=$(cat ~/vet-data-pipeline/patients/dogs.csv ~/vet-data-pipeline/patients/cats.csv | grep -i "healthy" | wc -l)
SICK=$(cat ~/vet-data-pipeline/patients/dogs.csv ~/vet-data-pipeline/patients/cats.csv | grep -i "sick" | wc -l)
RECOVERING=$(cat ~/vet-data-pipeline/patients/dogs.csv ~/vet-data-pipeline/patients/cats.csv | grep -i "recovering" | wc -l)

# Write report
cat > $REPORT_FILE << REPORT
VETERINARY CLINIC DAILY REPORT
Date: $DATE
==============================
PATIENT SUMMARY:
  Total Patients : $TOTAL
  Dogs           : $TOTAL_DOGS
  Cats           : $TOTAL_CATS
------------------------------
HEALTH STATUS:
  Healthy        : $HEALTHY
  Sick           : $SICK
  Recovering     : $RECOVERING
==============================
REPORT

echo "Report saved to $REPORT_FILE"

# Backup both patient files
cp ~/vet-data-pipeline/patients/dogs.csv $BACKUP_DIR/${DATESTAMP}_dogs.csv
cp ~/vet-data-pipeline/patients/cats.csv $BACKUP_DIR/${DATESTAMP}_cats.csv
echo "Backups saved to $BACKUP_DIR"

# Log the run
echo "[$DATE] Report generated. Total=$TOTAL Healthy=$HEALTHY Sick=$SICK Recovering=$RECOVERING" >> $LOG_FILE
echo "Logged to $LOG_FILE"
