#!/bin/bash

# Define directories to search
search_dirs=(~/.dotfiles ~/dev ~/notes)

# Check if fd is available
if command -v fd &> /dev/null; then
    files=$(fd . ${search_dirs[@]} --type f --hidden --follow --ignore-case --no-ignore && fd . $HOME -d 1 --type f --hidden --ignore-case)
# Check if find is available
elif command -v find &> /dev/null; then
    files=$(find "${search_dirs[@]}" -type f -name '.*' -prune -o -type f -print && find $HOME -maxdepth 1 -type f -name '.*' -prune -o -type f -print)
# Show error if neither tool is available
else
    echo "Error: Neither 'fd' nor 'find' is available on this system."
    exit 1
fi


if command -v bat &> /dev/null; then
    viewer="bat -n --color=always"
elif command -v cat &> /dev/null; then
    viewer="cat -n"
else
    echo "Error: Neither 'bat' nor 'cat' is available on this system."
    exit 1
fi

# Find files using fd or find, filter with fzf for interactive selection
selected_files=$(echo "$files" | fzf --layout=reverse --preview-window up --preview "$viewer {}" --bind ctrl-u:preview-up,ctrl-d:preview-down)

# If no file is selected, exit gracefully
if [ -z "$selected_files" ]; then
    exit 0
else
    # Extract directory path from the selected file
    dir=$(dirname "$selected_files")
    
    # Change directory to the path of the selected file and open it in nvim
    cd "$dir" && $EDITOR "$selected_files"
fi

