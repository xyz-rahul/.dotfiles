# ~/.bash_profile

if [[ "$(uname)" == "Darwin" ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

_add_to_path() {
    for path_entry in "$@"; do
        if ! [[ ":$PATH:" =~ ":$path_entry:" ]]; then
            PATH="$PATH:$path_entry"
        fi
    done
    export PATH
}

_add_to_path "$(brew --prefix)/anaconda3/bin"

_add_to_path "$HOME/.local/bin"
chmod +x $HOME/.local/bin/*


export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
fi
