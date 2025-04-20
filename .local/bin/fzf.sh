#!/bin/bash
DIRS=( "$HOME/dev" "$HOME/.dotfiles" )

# Define fd commands
fd_files='fd . ${DIRS[@]} --type f --hidden --follow --ignore-case --no-ignore --exclude .git && fd . $HOME -d 1 --type f --hidden --ignore-case'
fd_dirs='fd . ${DIRS[@]} --type d --hidden --follow --ignore-case --no-ignore --exclude .git  && fd . $HOME -d 1 --type d --hidden --ignore-case'

# Build bind args for toggle
bind_args="ctrl-d:reload(eval $fd_dirs),ctrl-f:reload(eval $fd_files)"

# Run fzf with toggle, clipboard copy, styling, and skipping directories
SELECTED_FILE=$(
    eval "$fd_files" | fzf \
    --bind="$bind_args" \
    --bind="ctrl-y:execute-silent(echo -n {2..} | pbcopy)" \
    --header="Press CTRL-Y to copy command into clipboard | Ctrl‑D → dirs | Ctrl‑F → files"
)

# If no file is selected, exit gracefully
if [ -z "$SELECTED_FILE" ]; then
    exit 0
elif [ -d "$SELECTED_FILE" ]; then
    cd "$SELECTED_FILE" && echo "pwd: $(pwd)"
else
    # Extract directory path from the selected file
    dir=$(dirname "$SELECTED_FILE")
    builtin cd "$dir" && ${EDITOR:-vim} "$SELECTED_FILE"
fi
