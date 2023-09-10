#!/usr/bin/bash
set -ex

sleep 20
# test1
timeout 20 curl -s http://54.209.148.229:5000

# <-- שורה מעודכנת -->
echo "Test finished successfully"  # פלט מובנה לפלט של Jenkins
