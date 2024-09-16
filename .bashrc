#!bash
case $- in
*i*) ;; # interactive
*) return ;;
esac

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
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend 

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
export CDPATH=".:$HOME"

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
if _have dircolors; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

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
alias g='git '

alias ga='git add --verbose'
alias gaa='git add --all --verbose'
alias gap='git add --patch --verbose'
alias gaap='git add --all --patch --verbose'
alias gau='git add --update'

alias gd='git diff'
alias gds='git diff --staged'

alias gs='git status'
alias gss='git status --short'
alias gsb='git status  --branch'
alias gssb='git status --short --branch'

alias gsw='git switch'

alias gc='git commit'
alias gca='git commit --amend'

alias gr='git rebase --interactive'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'

alias gR='git restore'
alias gRs='git restore --staged'

alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbm='git branch --merged'
alias gbnm='git branch --no-merged'

alias gf='git fetch'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'

alias gp='git push'
alias gpo='git push origin'

alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms='git merge --squash'

alias gSs='git stash save'
alias gSp='git stash push'
alias gSpa='git stash push --all'
alias gSP='git stash pop'
alias gSa='git stash apply'
alias gSd='git stash drop'
alias gSc='git stash clear'
alias gSl='git stash list'

alias gl="git log --graph --pretty=format:'%C(auto)%h%Creset - %C(auto)%d%Creset %C(auto)%s%Creset %C(bold green)(%cr)%Creset %C(italic 244)<%an>%Creset' --abbrev-commit "
alias gla="git log --graph --pretty=format:'%C(auto)%h%Creset - %C(auto)%d%Creset %C(auto)%s%Creset %C(bold green)(%cr)%Creset %C(italic 244)<%an>%Creset' --abbrev-commit --all"

