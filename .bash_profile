# ~/.bash_profile
if [[ "$(uname)" == "Darwin" ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

script_dir="$HOME/.local/bin"
export PATH="$PATH:$script_dir"
chmod +x $script_dir/*


if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
fi
