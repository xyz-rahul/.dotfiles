eval "$(/opt/homebrew/bin/brew shellenv)"
# Disable macOS message to change shell
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
fi
