#!/bin/bash
echo "Linux Space Saver (c)J~Net 2024"
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

# Prompt user to select tasks
echo "Select tasks to perform (enter number separated by spaces):"
echo "1. Remove unused packages"
echo "2. Clean cache and temporary files"
echo "3. Check for large files"
echo "4. Display expected space saved"
echo "5. Highlight unused programs in red"
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
        0) remove_unused_packages
           clean_cache
           check_large_files
           display_expected_space_saved
           highlight_unused_programs
           ;;
        *) echo "Invalid selection: $task";;
    esac
done

