#!bash

# Exit if the shell is not interactive (i.e., skip for scripts or non-login shells)
case $- in
*i*) ;; # interactive
*) return ;;
esac

# keep at the first of file -- wierd bugs
# bash_completion
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

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
bind -x '"\C-f":"fzf.sh"'



# ---------------------- start up code ---------------------

if command -v nvim &> /dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
    alias v='nvim'
fi

# Editor and grep settings
export GREP_OPTIONS='--color=always'

# Directory navigation aliases
# alias .="cd .."
# alias ..="cd ../.."
# alias ...="cd ../../.."
# alias ....="cd ../../../.."

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

set show-all-if-ambiguous on        # Single tab shows all matches when ambiguous
set completion-map-case on          # Allows case-insensitive key mapping for completion
set match-hidden-files on           # Includes hidden files (those starting with a dot) in completions
set mark-symlinked-directories on   # Displays symlinked directories with a special marker
set colored-stats on                # Provides colorful statistics for completions (like counts)

# ---------------------------- History Settings ----------------------------

shopt -s histappend # Append to the history file, don't overwrite it
shopt -s cmdhist # Save multi-line commands as one command

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

alias ga='git add --verbose'
alias gap='git add --patch --verbose'
alias gau='git add --update'

alias gd='git diff'
alias gds='git diff --staged'

alias gs='git status'
alias gss='git status --short'

alias gc='git commit'

alias gf='git fetch --all'

alias gp='git push'
alias gpo='git push origin'

alias gl="git log --graph --pretty=format:'%C(auto)%h%Creset - %C(auto)%d%Creset %C(auto)%s%Creset %C(bold green)(%cr)%Creset %C(italic 244)<%an>%Creset' --abbrev-commit "
alias gla="git log --graph --pretty=format:'%C(auto)%h%Creset - %C(auto)%d%Creset %C(auto)%s%Creset %C(bold green)(%cr)%Creset %C(italic 244)<%an>%Creset' --abbrev-commit --all"


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

