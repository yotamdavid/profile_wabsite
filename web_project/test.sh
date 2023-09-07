#!/usr/bin/bash
set -ex

sleep 20
# test1
timeout 20 curl -s http://52.87.200.27:5000

# <-- שורה מעודכנת -->
echo "Test finished successfully"  # פלט מובנה לפלט של Jenkins
