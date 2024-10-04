#!/usr/bin/env bash

if command -v rga &> /dev/null; then
    RG_PREFIX="rga --smart-case --files-with-matches --hidden --follow "
    DIR_LIST="~/notes ~/dev"
    file="$(
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$1' $DIR_LIST" \
            fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                --phony -q "$1" \
                --bind "change:reload:$RG_PREFIX {q}  $DIR_LIST" \
                --bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down \
                --layout=reverse \
                --preview-window="wrap:up"
    )"  
else
    echo "Error: rga tool not available"
    exit 1
fi

# If no file is selected, exit gracefully
if [ -z "$file" ]; then
    exit 0
else
    dir=$(dirname "$file")
    # Change directory to the path of the selected file and open it in editor
    cd "$dir" && $EDITOR "$file"
fi

