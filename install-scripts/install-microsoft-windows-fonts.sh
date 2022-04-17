#!/bin/bash

file_name="windows-main-fonts.tar.xz"

# The sha256sum of the original file.
font_hash_local="a1b250507f1a1401bb5220e56c00e764e842cfd55bef4f8f90e957aa4a0d989b  $file_name"
echo
echo "************** Downloading fonts from Discord CDN... **************"
echo
cd /tmp/
wget https://cdn.discordapp.com/attachments/910521923044274268/963827245909176330/$file_name

# Check if the original file has the same hash as the downloaded one.
font_hash_down=$(sha256sum $file_name)
if [[ ! "$font_hash_down" == "$font_hash_local" ]]; then
    rm $file_name
    echo
    echo "$(tput smso)$(tput setaf 1)************** File hash does't match, exiting... **************$(tput sgr0)"
    echo
    exit
fi

mkdir -p $HOME/.fonts
mv ./$file_name $HOME/.fonts/
cd $HOME/.fonts
echo
echo "$(tput setaf 2)************** Extracting fonts... **************$(tput sgr0)"
echo
tar -xJvf $file_name
rm $file_name
echo
echo "$(tput smso)$(tput setaf 2)************** All fonts were installed for the user in $HOME/.fonts/windows-main-fonts **************$(tput sgr0)"
echo
