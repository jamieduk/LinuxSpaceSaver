#!/bin/bash
# Linux Space Saver (c)J~Net 2024
# https://github.com/jamieduk/LinuxSpaceSaver
#
#
# ./linuxspacesaver.sh
#
# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit
fi
#
echo "Linux Space Saver (c)J~Net 2024"
echo ""
# Function to remove unused packages
remove_unused_packages() {
    echo "Removing unused packages..."
    sudo apt autoremove --purge -y
}

# Function to clean cache and temporary files
clean_cache() {
    echo "Cleaning cache and temporary files..."
    sudo apt clean
    sudo rm -rf /var/cache/apt/archives/*
    sudo rm -rf /var/tmp/*
    sudo rm -rf /tmp/*
}

# Function to check for large files and display the biggest ones
check_large_files() {
    echo "Checking for large files..."
    echo "The biggest files (ordered by biggest at top):"
    sudo du -ah / | sort -rh | head -n 10
}

# Function to display the expected space saved
display_expected_space_saved() {
    echo "Expected space saved after tasks would be complete:"
    df -h /
}

# Function to highlight unused programs in red
highlight_unused_programs() {
    echo "Highlighting unused programs in red..."
    sudo dpkg -l | grep '^rc' | awk '{print "\033[0;31m" $2 "\033[0m"}'
}

# Function to check disk space usage
checkspace(){
    df -h / | awk 'NR==2 {gsub("%","",$5); print $5}'
}

# Function to cleanup log files
cleanup_logs() {
    echo "Cleaning up log files..."
    # Truncate log files if they exist
    if [ -e /var/log/apache2/error.log ]; then
        sudo truncate -s 0 /var/log/apache2/error.log
    fi
    if [ -e /var/log/apache2/access.log ]; then
        sudo truncate -s 0 /var/log/apache2/access.log
    fi
    if [ -e /var/log/auth.log ]; then
        sudo truncate -s 0 /var/log/auth.log
    fi
    if [ -e /var/log/mail.log ]; then
        sudo truncate -s 0 /var/log/mail.log
    fi

    # Manage systemd journal
    sudo journalctl --rotate
    sudo journalctl --vacuum-time=2d
    sudo journalctl --vacuum-size=100M
}

# Function to remove trash files
remove_trash_files() {
    echo "Removing trash files..."
    # Remove trash files if the directory exists
    if [ -d /root/.local/share/Trash/files ]; then
        sudo find /root/.local/share/Trash/files -mindepth 2 -delete
    fi
    if [ -d /home/$USER/.local/share/Trash/files ]; then
        sudo find /home/$USER/.local/share/Trash/files -mindepth 2 -delete
    fi
}

# Function to remove package lists
remove_package_lists() {
    echo "Removing package lists..."
    sudo rm -rf /var/lib/apt/lists/*
}

# Prompt user to select tasks
echo "Select tasks to perform (enter number separated by spaces):"
echo "1. Remove unused packages"
echo "2. Clean cache and temporary files"
echo "3. Check for large files"
echo "4. Display expected space saved"
echo "5. Highlight unused programs in red"
echo "6. Cleanup log files"
echo "7. Remove trash files"
echo "8. Remove package lists"
echo "Enter '0' to execute all selected tasks"

read -p "Enter selection: " tasks

# Execute selected tasks
for task in $tasks; do
    case $task in
        1) remove_unused_packages;;
        2) clean_cache;;
        3) check_large_files;;
        4) display_expected_space_saved;;
        5) highlight_unused_programs;;
        6) cleanup_logs;;
        7) remove_trash_files;;
        8) remove_package_lists;;
        0) remove_unused_packages
           clean_cache
           check_large_files
           display_expected_space_saved
           highlight_unused_programs
           cleanup_logs
           remove_trash_files
           remove_package_lists
           ;;
        *) echo "Invalid selection: $task";;
    esac
done


