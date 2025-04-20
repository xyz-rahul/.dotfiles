#!/bin/bash

# Check if git-prompt.sh is executable and source it if found
if [ -x "$(command -v git-prompt.sh)" ]; then
    source "$(command -v git-prompt.sh)"   # Source git-prompt.sh for git prompt functionality
else
    echo "git-prompt.sh is not executable or not found."  # Error message if git-prompt.sh is not found or not executable
    
    echo -e "\nTo download git-prompt.sh, run the following command:"
    echo "curl -L 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' -o ~/.local/bin/git-prompt.sh"
    echo "chmod +x ~/.local/bin/git-prompt.sh"
    echo "source ~/.local/bin/git-prompt.sh"
fi

# Git Prompt Configuration
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true      # staged '+', unstaged '*'
export GIT_PS1_SHOWUNTRACKEDFILES=true  # '%' untracked files
export GIT_PS1_SHOWUPSTREAM="auto"      # '<' behind, '>' ahead, '<>' diverged, '=' no difference
export GIT_PS1_SHOWSTASHSTATE=true      # '$' something is stashed

GIT_PROMPT="\$(__git_ps1 \" (%s)\")"

# Define Custom Colors
GREEN="\[\033[38;5;35m\]"   # Green color for the username
MAGENTA="\[\033[0;35m\]"    # Magenta color for the hostname
BLUE="\[\033[0;34m\]"       # Blue color for the current working directory
RESET="\[\033[0m\]"         # Reset color to default


PS1="${GREEN}\u${RESET}@${MAGENTA}\h${RESET}:${BLUE}\w${RESET}${GIT_PROMPT}\n${GREEN}\$${RESET} "  # Custom prompt setup

export PS1
