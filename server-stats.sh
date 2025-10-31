#!/bin/bash
# server-stats.sh
# Script to display basic server performance statistics

echo "==============================================="
echo "        SERVER PERFORMANCE STATISTICS"
echo "==============================================="
echo

# CPU Usage
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
cpu_usage=$((100 - cpu_idle))
echo " Total CPU Usage: ${cpu_usage}%"
echo

# Memory Usage
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_usage_percent=$((100 * mem_used / mem_total))
echo " Memory Usage: ${mem_used}MB / ${mem_total}MB (${mem_usage_percent}%)"
echo

# Disk Usage
disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_usage=$(df -h / | awk 'NR==2 {print $5}')
echo " Disk Usage: ${disk_used} / ${disk_total} (${disk_usage})"
echo

# Top 5 Processes by CPU
echo " Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 Processes by Memory
echo " Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# (Optional Extra Info)
echo "==============================================="
echo "Additional Info"
echo "==============================================="
echo "🧩OS Version: $(lsb_release -d 2>/dev/null | cut -f2)"
echo " Uptime: $(uptime -p)"
echo " Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
echo " Logged-in Users: $(who | wc -l)"

