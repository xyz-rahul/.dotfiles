#!/bin/bash
# Define directories to search
search_dirs=(~/.dotfiles ~/dev ~/notes)

# Check if fd is available
if command -v fd &> /dev/null; then
    dir=$(fd . "${search_dirs[@]}" --type d --hidden --follow --exclude .git && fd . $HOME -d 1 --type d --hidden --exclude .git)
# Check if find is available
elif command -v find &> /dev/null; then
    dir=$(find "${search_dirs[@]}" -type d -name '.*' -prune -o -type d -print && find $HOME -maxdepth 1 -type d -name '.*' -prune -o -type d -print)
# Show error if neither tool is available
else
    echo "Error: Neither 'fd' nor 'find' is available on this system."
    exit 1
fi

# Find files using fd or find, filter with fzf for interactive selection
selected_dir=$(echo "$dir" | fzf --layout=reverse --preview 'tree -C -L 5 {}' --bind ctrl-u:preview-up,ctrl-d:preview-down)

if [ -d "$selected_dir" ]; then
    cd "$selected_dir" && echo "path: $(pwd)"
else
    exit 0
fi

