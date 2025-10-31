# 🖥️ Server Performance Stats Script

This project helps you **analyze the performance of any Linux server** easily using a simple Bash script.

It gives you important information about your system such as:
- CPU usage  
- Memory (RAM) usage  
- Disk (storage) usage  
- Top 5 processes using the most CPU  
- Top 5 processes using the most Memory  
- (Optional) Other details like OS version, uptime, and logged-in users

---

## 🚀 Goal of the Project

The goal is to **learn how to collect and analyze basic server performance stats** using simple Linux commands and Bash scripting.

This is useful for:
- Monitoring your own system performance  
- Learning how servers work  
- Practicing Bash scripting skills  

---

## 🧩 What You’ll Need

Before running the script, make sure you have:
- A **Linux system** (Ubuntu, CentOS, Debian, etc.)  
- Basic terminal access  
- The following commands available:  
  `top`, `free`, `df`, `ps`, `awk`, `uptime`, `lsb_release`

*(These come pre-installed in most Linux systems.)*

---

## ⚙️ How to Set Up

1. **Create a new file**
   ```bash
   nano server-stats.sh
Copy the script below into that file:

bash
Copy code
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
echo "🔹 Total CPU Usage: ${cpu_usage}%"
echo

# Memory Usage
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_usage_percent=$((100 * mem_used / mem_total))
echo "🔹 Memory Usage: ${mem_used}MB / ${mem_total}MB (${mem_usage_percent}%)"
echo

# Disk Usage
disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_usage=$(df -h / | awk 'NR==2 {print $5}')
echo "🔹 Disk Usage: ${disk_used} / ${disk_total} (${disk_usage})"
echo

# Top 5 Processes by CPU
echo "🔹 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 Processes by Memory
echo "🔹 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# (Optional Extra Info)
echo "==============================================="
echo "Additional Info"
echo "==============================================="
echo "🧩 OS Version: $(lsb_release -d 2>/dev/null | cut -f2)"
echo "🕒 Uptime: $(uptime -p)"
echo "⚙️  Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
echo "👤 Logged-in Users: $(who | wc -l)"
Save and exit (in nano: press Ctrl + O, Enter, then Ctrl + X)

Make it executable

bash
Copy code
chmod +x server-stats.sh
Run the script

bash
Copy code
./server-stats.sh
You’ll now see a report showing your system performance!

🧠 What Each Part Does (Explained Simply)
Let’s understand the script step by step.

1️⃣ CPU Usage
bash
Copy code
top -bn1 | grep "Cpu(s)"
This command shows how busy your CPU is.

We take the idle percentage (time CPU is resting) and subtract it from 100 to get actual CPU usage.

For example:
If CPU is 80% idle → usage = 100 - 80 = 20%

2️⃣ Memory (RAM) Usage
bash
Copy code
free -m
This shows total, used, and free memory in megabytes (MB).

We then calculate:

java
Copy code
Used Percentage = (Used / Total) * 100
and print it in a readable format.

3️⃣ Disk (Storage) Usage
bash
Copy code
df -h /
This shows how much disk space your root (/) drive is using.

We extract:

Total space

Used space

Percentage used (e.g., 45%)

4️⃣ Top 5 CPU-Hungry Processes
bash
Copy code
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
This lists all processes with:

PID: process ID

Command name

CPU usage

We sort them by CPU usage (highest first) and show top 5.

5️⃣ Top 5 Memory-Hungry Processes
bash
Copy code
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
Same as above, but sorted by Memory usage.

6️⃣ Extra Info (Optional)
We added:

OS version → lsb_release -d

Uptime (how long system is running) → uptime -p

Load average (system workload) → uptime

Logged-in users → who | wc -l

This gives extra context about your system’s health.

🧪 Example Output
When you run the script, you’ll see something like this:

yaml
Copy code
===============================================
        SERVER PERFORMANCE STATISTICS
===============================================

🔹 Total CPU Usage: 23%

🔹 Memory Usage: 2100MB / 7977MB (26%)

🔹 Disk Usage: 20G / 50G (40%)

🔹 Top 5 Processes by CPU Usage:
  PID COMMAND %CPU
  120 firefox  25.3
  280 chrome   15.2
  ...

🔹 Top 5 Processes by Memory Usage:
  PID COMMAND %MEM
  120 firefox  12.5
  280 chrome   9.2
  ...

===============================================
Additional Info
===============================================
🧩 OS Version: Ubuntu 22.04.3 LTS
🕒 Uptime: up 2 hours, 13 minutes
⚙️  Load Average: 0.10, 0.12, 0.08
👤 Logged-in Users: 1
💡 Tips
Run it every few hours to check your server’s performance.

You can schedule it with cron to get automatic reports.

Try adding more stats like network usage or failed login attempts if you want to improve it!

🏁 Conclusion
This simple Bash script helps you:

Understand how Linux performance tools work

Learn Bash scripting with practical commands

Monitor any Linux server easily

You can now proudly say:

“I can check my server’s health with my own script!”

👨‍💻 Author
Bablu Kumar
(DevOps & Cloud Enthusiast — loves automating things)
