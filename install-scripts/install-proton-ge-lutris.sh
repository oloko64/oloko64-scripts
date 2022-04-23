#!/usr/bin/env bash

green_message() {
    echo
    echo "$(tput setaf 2)************** $1 **************$(tput sgr0)"
    echo
}

green_message_strong() {
    echo
    echo "$(tput smso)$(tput setaf 2)************** $1 **************$(tput sgr0)"
    echo
}

yellow_message() {
    echo
    echo "$(tput setaf 3)************** $1 **************$(tput sgr0)"
    echo
}

red_message_strong() {
    echo
    echo "$(tput smso)$(tput setaf 1)************** $1 **************$(tput sgr0)"
    echo
}

# The pattern that the Lutris GE uses in the file name.
hardcode_unvariable_name="wine-lutris-GE-"

# The first argument from the user without the path.
file="${1##*/}"

# Check if the file was specified in the arguments.
[[ "$file" == "" ]] && yellow_message "No file specified, exiting..." && exit 1

# Get the unvariable name from the file name and checks if it is valid.
unvariable_name=$(echo "$file" | awk -F"Proton" '{print $1}')
[[ ! "$unvariable_name" == "$hardcode_unvariable_name" ]] && yellow_message "File name does not match the pattern, exitting..." && exit 1

# Gets the file name without the extension name.
file_name=$(echo "$file" | cut -f 1 -d '.')

# Gets the folder name to be used after the file extraction.
folder_name=$(echo "$file_name" | awk -F"wine-" '{print $2}')

# Extract the version of the file from the file name.
version_name=$(echo "$file_name" | awk -F"wine-lutris-" '{print $2}')
final_version_name=$(echo "$version_name" | awk -F"-x86_64" '{print $1}')

# Verification of the integrity of the file.
green_message "Verifiying file hash with github hash..."
echo "$folder_name"
wget "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/$final_version_name/$file_name.sha512sum"
echo
sha512sum_github=$(cat "$file_name.sha512sum")
sha512sum_file=$(sha512sum $file)

# Delete files and exit in case of mismatch hash.
if [[ "$sha512sum_github" != "$sha512sum_file" ]]; then
    red_message_strong "Hash mismatch, check the file before installing it..."
    rm "$file_name.sha512sum"
    exit 1
fi

# Removes the sha512sum file, extract the file and move it to the lutris default wine folder, inside $HOME/.local/share/lutris/runners/wine/.
rm "$file_name.sha512sum"
green_message_strong "Hash match, proceding with installation..."
sleep 2
tar -xJvf "$file"
mkdir -p "$HOME/.local/share/lutris/runners/wine/"
mv "$folder_name" "$HOME/.local/share/lutris/runners/wine/"
green_message_strong "$folder_name is installed successfully..."
