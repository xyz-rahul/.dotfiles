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



# ---------------------- start up code ---------------------
# bash_completion
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

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

# -------------------------- Bash Shell Options --------------------------

shopt -s checkwinsize     # update terminal size on screen size change
shopt -s expand_aliases   # allow alias expansion in sudo
shopt -s dotglob          # include dotfiles in globs
shopt -s extglob          # Extended pattern matching in filename expansion
shopt -s cmdhist          # save multiline cmd as one
shopt -s histappend       # append to history file

# ------------------------------ cdpath ------------------------------
export CDPATH=".:$HOME"

# ---------------------------- History Settings ----------------------------

export HISTCONTROL=ignorespace:erasedups     # ignore space, remove dups
export HISTSIZE=500                          # history size in memory
export HISTFILESIZE=10000                    # history file size
export HISTIGNORE="ls*:ll:exit:clear:cd*:top:htop*:history*:rm*"  # ignore these cmds

export PROMPT_COMMAND='history -a; history -n'

# ----------------------------- dircolors ----------------------------

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

# ---------------------------- Aliases ----------------------------

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'  # notify on long cmd

alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"  # tail all log files


# ---------------------------- FZF ----------------------------

eval "$(fzf --bash)"

export FZF_CTRL_R_OPTS="
                      --preview 'echo {}' --preview-window up:3:hidden:wrap
                      --bind 'ctrl-y:execute-silent(echo -n {2..} | $copy)'
                      --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_CTRL_T_OPTS="
                    --walker-skip .git,node_modules,target
                    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf "$@" ;;
  esac
}

# --------------------------- smart prompt ---------------------------
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


# -------------------- GIT -------------------
# Enable Git completion if available
[ -f "$HOME/git-completion.bash" ] && source "$HOME/git-completion.bash" || printf "not found git-completion.bash\n"


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

