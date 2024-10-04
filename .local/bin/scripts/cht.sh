#!/bin/bash

CACHE_FILE="$HOME/.cache/cheat_sh_cache"

# Check if the cache file exists and is not older than 1 day
if [[ -f $CACHE_FILE && $(find $CACHE_FILE -mtime -1) ]]; then
    cheat_sheets=$(cat $CACHE_FILE)
else
    # Fetch the list of available cheat sheets and cache it
    cheat_sheets=$(curl -s cht.sh/:list)
    echo "$cheat_sheets" > $CACHE_FILE
fi


# Fetch the list of available cheat sheets
cheat_sheets=$(curl -s cht.sh/:list)

# Use fzf to select a cheat sheet
selected=$(echo "$cheat_sheets" | fzf --prompt="Select a cheat sheet: ")

# If no selection is made, exit
if [[ -z $selected ]]; then
    echo "No selection made. Exiting."
    exit 0
fi

# Prompt for the query
read -p "Enter Query: " query
query=`echo $query | tr ' ' '+'`

# Fetch the cheat sheet for the selected item and query, then open in less
echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done
