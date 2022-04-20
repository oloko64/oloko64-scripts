#/bin/bash

green_message() {
    echo
    echo "$(tput setaf 2)************** $1 **************$(tput sgr0)"
    echo
}

red_message_strong() {
    echo
    echo "$(tput smso)$(tput setaf 1)************** $1 **************$(tput sgr0)"
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

update_repository() {
    cd $1
    if [[ -d .git ]]; then
        green_message "Updating repository $1..."
        git pull
    else
        echo "$(tput setaf 3)************** $1 doesn't contain .git directory... **************$(tput sgr0)"
    fi
    cd ..
}

path_folder=$1

if [[ ! "$path_folder" == "" ]]; then
    if [[ ! -d "$path_folder" ]]; then
        red_message_strong "Folder $path_folder doesn't exist, exiting..."
        exit 1
    fi
    cd $path_folder
fi
for folder in *; do
    if [[ -d "$folder" ]]; then
        update_repository "$folder"
    fi
done
green_message_strong "All repositories were updated"
