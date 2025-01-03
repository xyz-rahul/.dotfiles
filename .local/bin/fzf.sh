#!/bin/bash
if command -v bat &>/dev/null; then
    viewer="bat -n --color=always"
elif command -v cat &>/dev/null; then
    viewer="cat -n"
else
    echo "Error: Neither 'bat' nor 'cat' is available on this system."
    exit 1
fi

# Directories to search
DIRS=("$HOME/dev" "$HOME/.dotfiles")

SELECTED_FILE=$(
    {
        fd . "${DIRS[@]}" --type f --hidden --follow --ignore-case --no-ignore &
        fd . "$HOME" -d 1 --type f --hidden --ignore-case
    } |
        fzf --ansi --layout=reverse --preview-window up --preview "$viewer {}" --bind ctrl-u:preview-up,ctrl-d:preview-down
)

# If no file is selected, exit gracefully
if [ -z "$SELECTED_FILE" ]; then
    exit 0
else
    # Extract directory path from the selected file
    dir=$(dirname "$SELECTED_FILE")

    cd "$dir" && $EDITOR "$SELECTED_FILE"
fi
