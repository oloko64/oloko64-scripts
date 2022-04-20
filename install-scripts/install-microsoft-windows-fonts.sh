#!/bin/bash

green_message() {
    echo "$(tput setaf 2)************** $1 **************$(tput sgr0)"
}

green_message_strong() {
    echo "$(tput smso)$(tput setaf 2)************** $1 **************$(tput sgr0)"
}

red_message_strong() {
    echo "$(tput smso)$(tput setaf 1)************** $1 **************$(tput sgr0)"
}

file_name="windows-main-fonts.tar.xz"

# The sha256sum of the original file.
font_hash_local="a1b250507f1a1401bb5220e56c00e764e842cfd55bef4f8f90e957aa4a0d989b  $file_name"
green_message "Downloading fonts from Discord CDN..."
cd /tmp/
wget https://cdn.discordapp.com/attachments/910521923044274268/963827245909176330/$file_name

# Check if the original file has the same hash as the downloaded one.
font_hash_down=$(sha256sum $file_name)
if [[ ! "$font_hash_down" == "$font_hash_local" ]]; then
    rm $file_name
    red_message_strong "File hash does't match, exiting..."
    exit
fi

mkdir -p $HOME/.fonts
mv ./$file_name $HOME/.fonts/
cd $HOME/.fonts
green_message "Extracting fonts..."
tar -xJvf $file_name
rm $file_name
green_message_strong "All fonts were installed for the user in $HOME/.fonts/windows-main-fonts"
