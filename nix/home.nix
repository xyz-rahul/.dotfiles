# home-manager switch
{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    neofetch # A tool that displays system information in a visually appealing way
    direnv # An environment variable manager for shell, automating environment setup per directory
    neovim # An extensible text editor, a modern take on Vim

    # Utility Tools
    fd # A fast and user-friendly alternative to 'find' for searching files and directories
    ripgrep # A line-oriented search tool that recursively searches your current directory for a regex pattern
    jq # A lightweight and flexible command-line JSON processor for parsing and manipulating JSON data
    yq-go # A command-line YAML processor for reading and writing YAML files (https://github.com/mikefarah/yq)
    fzf # A command-line fuzzy finder, useful for searching through lists interactively

    aria2 # A lightweight multi-protocol & multi-source command-line download utility for downloading files

    btop # An interactive process viewer and resource monitor, a modern replacement for htop/nmon

    wezterm # terminal
    tmux
  ];

    home.file = {
        # Shell configurations
        ".bash_profile".source = ~/.dotfiles/.bash_profile;
        ".bashrc".source = ~/.dotfiles/.bashrc;

        # Directory colors and Vim configurations
        ".dircolors".source = ~/.dotfiles/.dircolors;
        ".ideavimrc".source = ~/.dotfiles/.ideavimrc;
        ".vimrc".source = ~/.dotfiles/.vimrc;

        # Keybinding configurations
        ".skhdrc".source = ~/.dotfiles/.skhdrc;
        ".yabairc".source = ~/.dotfiles/.yabairc;

        # Tmux configuration
        ".config/tmux/tmux.conf".source = ~/.dotfiles/tmux.conf;

        # Notes and other files
        "notes".source = ~/.dotfiles/notes;
        "waifu".source = ~/.dotfiles/waifu;

        # Local binaries
        ".local/bin/" = {
            source = ~/.dotfiles/.local/bin;
            recursive = true;
        };

        # Karabiner configuration
        ".config/karabiner/karabiner.json".source = ~/.dotfiles/karabiner.json;

        # WezTerm configuration
        ".config/wezterm" = {
            source = ~/.dotfiles/wezterm;
            recursive = true;
        };

        # Neovim configuration
        ".config/nvim" = {
            source = ~/.dotfiles/nvim;
            recursive = true;
        };
    };


  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  xsession.initExtra = ''
    . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
  '';

  programs.home-manager.enable = true;

  home.stateVersion = "24.05"; # Please read the comment before changing.
}
