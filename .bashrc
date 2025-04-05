#!bash

# Exit if the shell is not interactive (i.e., skip for scripts or non-login shells)
case $- in
*i*) ;; # interactive
*) return ;;
esac

# ---------------------- local utility functions ---------------------

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

_tmux() {
  if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      exec $(tmux a || tmux)
  fi
}

# custom hotkeys
bind -x '"\C-b":"_tmux"'

bind -x '"\C-f": "fzf.sh"'


# ---------------------- start up code ---------------------
eval "$(fzf --bash)"

if command -v nvim &> /dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
    alias v='nvim'
fi

# Editor and grep settings
export GREP_OPTIONS='--color=always'

# Directory navigation aliases
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."

# -------------------- os based setting -------------------
UNAME=$(uname)

if [ "$UNAME" == "Linux" ] ; then
    export copy='xclip -selection clipboard'
    export paste='xclip -selection clipboard -o'
elif [ "$UNAME" == "Darwin" ] ; then
    export copy='pbcopy'
    export paste='pbpaste'
elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
    export copy='clip'
    export paste='powershell Get-Clipboard'
fi


# ------------------------------ history -----------------------------

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTIGNORE=”ls:ll:exit:clear:cd:top:htop*:history*:rm*”

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

shopt -s cmdhist

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi


# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend 

# Ensure history is appended immediately and shared
export PROMPT_COMMAND='history -a; history -n'



# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"


export FZF_CTRL_R_OPTS="
                      --preview 'echo {}' --preview-window up:3:hidden:wrap
                      --bind 'ctrl-y:execute-silent(echo -n {2..} | $copy)'
                      --header 'Press CTRL-Y to copy command into clipboard'"

# ------------------------------ cdpath ------------------------------
# export CDPATH=".:$HOME"

# ------------------------ bash shell options ------------------------
# shopt is for BASHOPTS, set is for SHELLOPTS
shopt -s checkwinsize # enables $COLUMNS and $ROWS
shopt -s expand_aliases
shopt -s dotglob
shopt -s extglob

# --------------------------- smart prompt ---------------------------
#                 (keeping in bashrc for portability
git_prompt ()
{
  # Is this a git directory?
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${git_clean_color}"
  else
    git_color="${git_dirty_color}"
  fi
  echo " [$git_color$git_branch${reset_color}]"
}
PS1="\[\033[38;5;35m\][\u\[\033[38;5;35m\]] [\[\033[38;5;33m\]\j\[\033[38;5;35m\]] [\h:\[$(tput sgr0)\]\[\033[38;5;33m\]\w\[\033[38;5;35m\]]\[$(tput setaf 3)\]\$(git_prompt) \n\\[\033[38;5;35m\]$ \[$(tput sgr0)\]"

# ----------------------------- dircolors ----------------------------
# if _have dircolors; then
# 	if [[ -r "$HOME/.dircolors" ]]; then
# 		eval "$(dircolors -b "$HOME/.dircolors")"
# 	else
# 		eval "$(dircolors -b)"
# 	fi
# fi

export CLICOLOR=1 # colorful ls

# ----------------------------- pager ----------------------------
export LESS="-FXR"
export LESS_TERMCAP_mb="[35m" # magenta
export LESS_TERMCAP_md="[33m" # yellow
export LESS_TERMCAP_me=""      # "0m"
export LESS_TERMCAP_se=""      # "0m"
export LESS_TERMCAP_so="[34m" # blue
export LESS_TERMCAP_ue=""      # "0m"
export LESS_TERMCAP_us="[4m"  # underline

# -------------------- git alias -------------------

alias ga='git add --verbose'
alias gap='git add --patch --verbose'
alias gau='git add --update'

alias gd='git diff'
alias gds='git diff --staged'

alias gs='git status'
alias gss='git status --short'


alias gc='git commit'

alias gr='git restore'
alias grs='git restore --staged'

alias gf='git fetch --all'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'

alias gp='git push'
alias gpo='git push origin'


alias gl="git log --graph --pretty=format:'%C(auto)%h%Creset - %C(auto)%d%Creset %C(auto)%s%Creset %C(bold green)(%cr)%Creset %C(italic 244)<%an>%Creset' --abbrev-commit "
alias gla="git log --graph --pretty=format:'%C(auto)%h%Creset - %C(auto)%d%Creset %C(auto)%s%Creset %C(bold green)(%cr)%Creset %C(italic 244)<%an>%Creset' --abbrev-commit --all"



gclone() {
    # Define color variables at the start
    RED='\033[1;31m'
    GREEN='\033[1;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[1;34m'
    NC='\033[0m'  # No Color

    if [ -z "$1" ]; then
        echo -e "\n${RED}Error:${NC} Missing argument."
        echo -e "${YELLOW}Usage:${NC} ggc <github-repo-url>\n"
        return 1
    fi

    local origin="$1"
    local new_owner="reglobe"  # New owner for the upstream repository

    # Validate URL format (supports both HTTPS and SSH formats)
    if [[ ! "$origin" =~ ^(https:\/\/github\.com\/|git@github\.com:)[^/]+\/[^/]+(\.git)?$ ]]; then
        echo -e "\n${RED}Error:${NC} Invalid GitHub repository URL."
        echo -e "${YELLOW}Expected formats:${NC}"
        echo -e "  - HTTPS: https://github.com/user/repo.git"
        echo -e "  - SSH:   git@github.com:user/repo.git\n"
        return 1
    fi

    # Extract the repo name and owner from HTTPS or SSH URLs
    local repo_name=$(basename -s .git "$origin")
    local owner=$(echo "$origin" | sed -E 's#.*github.com[:/]([^/]+)/.*#\1#')

    # Replace the owner with the new owner
    local upstream="${origin/$owner/$new_owner}"

    # Check if the user has access to the repository
    echo -e "\n${BLUE}Checking access to the repository...${NC}"
    if git ls-remote "$origin" &>/dev/null; then
        echo -e "${GREEN}Access verified!${NC}"
    else
        echo -e "${RED}Error:${NC} Cannot access the repository. Check if it's private or if you have the correct permissions.\n"
        return 1
    fi

    # Clone the repository
    echo -e "\n${BLUE}Cloning repository:${NC} $origin\n"
    git clone "$origin"

    # Navigate into the repo directory
    if cd "$repo_name"; then
        echo -e "\n${BLUE}Setting upstream remote:${NC} $upstream\n"
        git remote add upstream "$upstream"

        echo -e "\n${GREEN}Remotes configured successfully:${NC}\n"
        git remote -v
        echo "" # Extra line break at the end for better separation
    else
        echo -e "\n${RED}Error:${NC} Failed to enter directory $repo_name\n"
        return 1
    fi
}

ww() {
    local dir
    dir=$(find ~/dev/workspace -maxdepth 1 -type d | sed 's|.*/||' | fzf) 

    if [[ -z "$dir" ]]; then
        echo "Error: No directory selected." >&2
        return 1
    fi

    cd ~/dev/workspace/"$dir" || { echo "Error: Failed to change directory to $dir" >&2; return 1; }
    idea ~/dev/workspace/"$dir"  # Open in IntelliJ without running in the background
}

