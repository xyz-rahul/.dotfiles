#!bash
case $- in
*i*) ;; # interactive
*) return ;;
esac

# ---------------------- start up code ---------------------

# run export PATH="$PATH:$HOME/scripts"

if [ -z "$TMUX" ]; then
    tmux attach -t TMUX || tmux new -s TMUX
fi

eval "$(fzf --bash)"

# Editor and grep settings

export EDITOR=nvim
export VISUAL=nvim
export GREP_OPTIONS='--color=always'
alias v='nvim'
alias db='nvim +DBUI'

# Directory navigation aliases
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."


# ---------------------- local utility functions ---------------------

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }


# ------------------------------ history -----------------------------

export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTIGNORE=”ls:ll:exit:clear:cd:top:htop*:history*:rm*”
shopt -s cmdhist
set -o vi
shopt -s histappend 

export FZF_CTRL_R_OPTS="
                      --preview 'echo {}' --preview-window up:3:hidden:wrap
                      --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
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
