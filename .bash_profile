eval "$(/opt/homebrew/bin/brew shellenv)"
# Disable macOS message to change shell
export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH="$PATH:$HOME/scripts"

script_dir="$HOME/scripts"
# Check if the directory exists
if [ -d "$script_dir" ]; then
    # Loop through each file in the directory
    for file in $HOME/scripts/*; do
        chmod +x "$file"
    done
else
    echo "Directory $script_dir does not exist."
fi

script_dir="$HOME/.local/bin"
export PATH="$PATH:$script_dir"
chmod +x $script_dir/*


if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
fi
