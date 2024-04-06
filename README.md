emergency_space.sh: Reclaim Disk Space on Raspberry Pi
This script helps reclaim disk space on a Raspberry Pi running Raspbian OS. It's designed to be a quick and easy way to free up space when your system is running low.

How to Use

Save the script as emergency_space.sh.
Make the script executable:
Bash
chmod +x emergency_space.sh
Use code with caution.
Run the script:
Bash
./emergency_space.sh
Use code with caution.
What it Does

The script performs the following actions:

Checks the current free disk space.
Truncates (clears) Apache error, access, authentication, and mail logs if they exist.
Rotates and vacuums the systemd journal to optimize its size.
Cleans the APT cache and removes unnecessary packages.
Removes trash files from the root and user directories (if the Trash directory exists).
Removes package lists.
Checks the amount of freed disk space and displays the difference.
Identifies the largest log files currently on the system.
Important Notes

This script truncates logs. Truncated logs lose their previous data. Ensure you don't need the log information before running the script.
Be cautious when deleting files. Running sudo commands grants the script root privileges, so double-check the commands before running the script.
This script is a helpful tool for regaining disk space on your Raspberry Pi, but it's recommended to understand what each command does before running it.
