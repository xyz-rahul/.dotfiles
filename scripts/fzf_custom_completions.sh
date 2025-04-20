# #!/bin/bash

# Check if fzf is installed, and if not, return early from the script
if [[ ! $(command -v fzf 2>/dev/null) ]]; then
  return
fi

eval "$(fzf --bash)"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --ansi"

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

if command -v bfs >/dev/null 2>&1; then # Check if bfs is installed
    _fzf_compgen_path() {
        bfs -H "$1" -L -color -unique -exclude \( -name .git -o -name node_modules \) 2>/dev/null
    }

    _fzf_compgen_dir() {
        bfs -H "$1" -L -color -unique -exclude \( -name .git -o -name node_modules \) -type d 2>/dev/null
    }
fi

# FZF Completion Setup — With Trigger Disabled for Specific Commands
_fzf_complete_cd_notrigger() {
  FZF_COMPLETION_TRIGGER='' _fzf_dir_completion
}
complete -o bashdefault -o dirnames -o nospace -F _fzf_complete_cd_notrigger cd

_fzf_complete_ls_notrigger() {
  FZF_COMPLETION_TRIGGER='' _fzf_path_completion
}
complete -o default -F _fzf_complete_ls_notrigger ls

_fzf_complete_cp_notrigger() {
  FZF_COMPLETION_TRIGGER='' _fzf_path_completion
}
complete -o default -F _fzf_complete_cp_notrigger cp

_fzf_complete_mv_notrigger() {
  FZF_COMPLETION_TRIGGER='' _fzf_path_completion
}
complete -o default -F _fzf_complete_mv_notrigger mv

_fzf_complete_rm_notrigger() {
  FZF_COMPLETION_TRIGGER='' _fzf_path_completion
}
complete -o default -F _fzf_complete_rm_notrigger rm

_fzf_complete_cat_notrigger() {
  FZF_COMPLETION_TRIGGER='' _fzf_path_completion
}
complete -o default -F _fzf_complete_cat_notrigger cat

_fzf_complete_ssh_notrigger() {
  FZF_COMPLETION_TRIGGER='' _fzf_host_completion
}
complete -F _fzf_complete_ssh_notrigger ssh
