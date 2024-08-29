#!bash
case $- in
*i*) ;; # interactive
*) return ;;
esac

# ---------------------- start up code ---------------------
eval "$(fzf --bash)"

# Editor and grep settings
export EDITOR=nvim
export VISUAL=nvim
export GREP_OPTIONS='--color=always'
alias v='nvim'

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
    exec tmux a || tmux
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
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
PS1="\[\033[38;5;35m\][\u\[\033[38;5;35m\]] [\[\033[38;5;33m\]\j\[\033[38;5;35m\]] [\h:\[$(tput sgr0)\]\[\033[38;5;33m\]\w\[\033[38;5;35m\]]\[$(tput setaf 3)\]\$(parse_git_branch) \n\\[\033[38;5;35m\]$ \[$(tput sgr0)\]"

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
