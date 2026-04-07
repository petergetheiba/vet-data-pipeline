#!/bin/bash
# filter_sick.sh - Filters sick animals from all patient files

echo "Running sick animal filter..."

# Combine all patient files and filter sick ones
cat ~/vet-data-pipeline/patients/dogs.csv ~/vet-data-pipeline/patients/cats.csv \
  | grep -i "sick\|recovering" \
  > ~/vet-data-pipeline/data/processed/sick_animals.csv

echo "name,breed,age,condition" | cat - ~/vet-data-pipeline/data/processed/sick_animals.csv > /tmp/temp && mv /tmp/temp ~/vet-data-pipeline/data/processed/sick_animals.csv

echo "Done! Sick animals saved to data/processed/sick_animals.csv"
cat ~/vet-data-pipeline/data/processed/sick_animals.csv
