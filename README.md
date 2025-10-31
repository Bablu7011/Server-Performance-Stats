# 🖥️ Server Performance Stats Script

This project helps you **analyze the performance of any Linux server** easily using a simple Bash script.

It gives you important information such as:
- 🧠 CPU usage  
- 💾 Memory usage  
- 💽 Disk usage  
- 🔥 Top 5 processes using the most CPU  
- 📦 Top 5 processes using the most Memory  
- ℹ️  Additional details like OS version, uptime, and logged-in users  

---

## 🚀 Goal of the Project

The goal is to learn how to collect and analyze basic server performance stats using simple Linux commands and Bash scripting.

This is useful for:
- Monitoring your own system performance  
- Learning how servers work  
- Practicing Bash scripting skills  

---

## ⚙️ Requirements

Before running the script, make sure you have:
- A **Linux system** (Ubuntu, CentOS, Debian, etc.)
- Terminal access  
- The following tools installed:  
  `top`, `free`, `df`, `ps`, `awk`, `uptime`, `lsb_release`

*(These are already included in most Linux systems.)*

---

## 🧩 Setup Instructions

### 1️⃣ Create the Script
Open your terminal and create a new file:
~~~
nano server-stats.sh
2️⃣ Copy and Paste the Code
Paste the following code inside:

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
~~~
3️⃣ Save and Exit
Press:
CTRL + O  → Enter  → CTRL + X

4️⃣ Make Executable
chmod +x server-stats.sh

5️⃣ Run the Script
./server-stats.sh

🧠 How the Script Works (Explained Simply)
🖥️ CPU Usage
top -bn1 | grep "Cpu(s)"
This shows the CPU idle percentage.
We subtract it from 100 to find how busy the CPU is:
CPU Usage = 100 - idle

💾 Memory Usage
free -m
This shows total, used, and free RAM in MB.
We use:
Used % = (Used / Total) * 100
If usage is above 80%, it turns red. Otherwise, green.

💽 Disk Usage
df -h /
Shows total, used, and available storage for your root partition /.

We extract data and calculate usage percentage.
Again, color changes if usage > 80%.

🔥 Top 5 Processes by CPU
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
Let’s break it down:
Part	Meaning	Explanation
ps	Process Status	Lists running processes (like Task Manager).
-e	Every process	Shows all processes, not just yours.
-o pid,comm,%cpu	Output format	Displays only Process ID, Command Name, and CPU %.
--sort=-%cpu	Sorting	Sorts results by CPU usage in descending order.
head -n 6	Top 6 lines	Shows 1 header + 5 process entries.

💡 This means:

“Show the top 5 programs that are using the most CPU.”

📦 Top 5 Processes by Memory
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
Same as above, but sorted by memory usage instead of CPU.

ℹ️ Extra Info
Commands used:

lsb_release -d → OS version

uptime -p → How long system is running

uptime → System load average

who | wc -l → Number of logged-in users

🧪 Example Output
~~~
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
~~~
🏁 Conclusion
This simple Bash script helps you:

Understand how Linux system stats work

Learn Bash scripting step by step

Monitor any server easily 

You can now proudly say:

“I built my own mini system monitor in Bash!” 🥳

#######################################################
Project_Url = https://roadmap.sh/projects/server-stats
#######################################################
👨‍💻 Author
Bablu Kumar
DevOps & Cloud Enthusiast — loves automating things
