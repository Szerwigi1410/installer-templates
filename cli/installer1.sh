#!/bin/bash

# This script interactively installs either 'brokefetch.sh' or 'brokefetch_EDGE.sh'
# from the current directory to /usr/bin. It prompts the user for choices.

GREEN="\033[32m"
RED="\033[31m"
BLUE="\033[34m"
CYAN="\033[36m"
WHITE="\033[37m"
YELLOW="\033[33m"
PURPLE="\033[35m"
BOLD="\033[1m"
RESET="\033[0m"
BLACK="\033[30m"
GRAY="\033[90m"

toInstall="niger.sh"

# --- Step 1: Identify available source files ---

available_scripts=()
if [ -f $toInstall ]; then
    available_scripts+=($toInstall)
fi

# Exit if no source files are found
if [ ${#available_scripts[@]} -eq 0 ]; then
    echo -e "${RED}Error code 002:${RESET} SHerFile.sh and SherFile_beta.sh were not found in the current directory."
    exit 1
fi

# --- Step 2: Prompt user for choice if multiple scripts are found ---

source_file=""
if [ ${#available_scripts[@]} -eq 1 ]; then
    source_file="${available_scripts[0]}"
    echo "Found '${source_file}'. This script will be installed."
fi

# --- Step 3: Check for existing installation and prompt for overwrite/remove ---

# Check if an old version of brokefetch exists
if [ -f "/usr/bin/${toInstall}" ]; then
    echo "An existing ${toInstall} script was found at /usr/bin/${toInstall}."
    
    # Prompt the user to remove or replace
    while true; do
        read -p "Do you want to (r)eplace it or (x) to remove it first? (r/x) " action
        case "$action" in
            [Rr]* ) 
                echo "Replacing existing SHerFile script."
                break
                ;;
            [Xx]* )
                echo "Removing old version before installation."
                sudo rm /usr/bin/${toInstall}
                break
                ;;
            * ) 
                echo "Invalid input. Please enter 'r' or 'x'."
                ;;
        esac
    done
fi

# --- Step 4: Perform the installation ---

echo "Installing '$source_file' to /usr/bin/${toInstall}..."

# Copy the chosen file to /usr/bin
sudo cp "$source_file" /usr/bin/${toInstall}

# Make the new file executable (not needed if the is binary)
sudo chmod +x /usr/bin/${toInstall}

# --- Step 5: Verify installation and provide success message ---

if [ -f "/usr/bin/${toInstall}" ]; then
    echo "Success! '$source_file' is now installed as '${toInstall}'."
    echo "You can run it from any directory by typing '${toInstall}'."
else
    echo -e "${RED}Error code 003:${RESET} an occurred during installation."
    exit 1
fi

exit 0

