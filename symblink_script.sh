#!/bin/bash

# Function to create symbolic links with confirmation
create_symlink() {
    local target=$1
    local link_name=$2

    # Check if the target link_name already exists
    if [ -e "$link_name" ] || [ -L "$link_name" ]; then
        read -p "$link_name already exists. Do you want to overwrite it? (y/n): " choice
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            echo "Removing existing file/link: $link_name"
            rm -f "$link_name"
        else
            echo "Skipping: $link_name"
            return 1  # Skip if user does not want to overwrite
        fi
    fi

    # Create the symlink if not skipped
    ln -s "$target" "$link_name"
    echo "Created symlink: $link_name -> $target"
}

# Creating the symbolic links
create_symlink "$(pwd)/.bash_profile" ~/.bash_profile
create_symlink "$(pwd)/.bashrc" ~/.bashrc
create_symlink "$(pwd)/.dircolors" ~/.dircolors
create_symlink "$(pwd)/.ideavimrc" ~/.ideavimrc
create_symlink "$(pwd)/.local/bin" ~/.local/bin
create_symlink "$(pwd)/.skhdrc" ~/.skhdrc
create_symlink "$(pwd)/.vimrc" ~/.vimrc
create_symlink "$(pwd)/.yabairc" ~/.yabairc
create_symlink "$(pwd)/karabiner.json" ~/.config/karabiner/karabiner.json
create_symlink "$(pwd)/notes" ~/notes
create_symlink "$(pwd)/nvim" ~/.config/nvim
create_symlink "$(pwd)/.tmux.conf" ~/.tmux.conf
create_symlink "$(pwd)/waifu" ~/waifu
create_symlink "$(pwd)/wezterm" ~/.config/wezterm

