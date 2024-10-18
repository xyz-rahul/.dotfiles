# eval "$(/opt/homebrew/bin/brew shellenv)"
# Disable macOS message to change shell
export BASH_SILENCE_DEPRECATION_WARNING=1
export HOMEBREW_NO_AUTO_UPDATE=1

script_dir="$HOME/.local/bin"
export PATH="$PATH:$script_dir"
chmod +x $script_dir/*


if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
fi
