#!/bin/bash

echo

# The pattern that the Lutris GE uses in the file name.
hardcode_unvariable_name="wine-lutris-GE-"

# The first argument from the user.
file="$1"

# Check if the file was specified in the arguments.
[ "$file" == "" ] && echo "$(tput setaf 3)************** No file specified, exiting... **************$(tput sgr0)" && echo && exit 1

# Get the unvariable name from the file name and checks if it is valid.
unvariable_name=$(echo "$file" | awk -F"Proton" '{print $1}')
[ ! "$unvariable_name" == "$hardcode_unvariable_name" ] && echo "$(tput setaf 3)************** File name does not match the pattern, exitting... **************$(tput sgr0)" && echo && exit 1

# Gets the file name without the extension name.
file_name=$(echo "$file" | cut -f 1 -d '.')

# Gets the folder name to be used after the file extraction.
folder_name=$(echo "$file_name" | awk -F"wine-" '{print $2}')

# Verification of the integrity of the file.
echo
echo "$(tput setaf 2)************** Verifiying file hash with github hash... **************$(tput sgr0)"
echo
echo "$folder_name"
wget "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton7-8/$file_name.sha512sum"
echo
sha512sum_github=$(cat "$file_name.sha512sum")
sha512sum_file=$(sha512sum $file)

# Delete files and exit in case of mismatch hash.
if [ "$sha512sum_github" != "$sha512sum_file" ]; then
    echo
    echo "$(tput smso)$(tput setaf 1)************** Hash mismatch, check the file before installing it... **************$(tput sgr0)"
    echo
    rm "$file_name.sha512sum"
    exit 1
fi

# Removes the sha512sum file, extract the file and move it to the lutris default wine folder, inside $HOME/.local/share/lutris/runners/wine/.
rm "$file_name.sha512sum"
echo
echo "$(tput smso)$(tput setaf 2)************** Hash match, proceding with installation... **************$(tput sgr0)"
echo
sleep 2
tar -xJvf "$file"
mkdir -p "$HOME/.local/share/lutris/runners/wine/"
mv "$folder_name" "$HOME/.local/share/lutris/runners/wine/"
echo
echo "$(tput smso)$(tput setaf 2)************** $folder_name is installed successfully... **************$(tput sgr0)"
echo
