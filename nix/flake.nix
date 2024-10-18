{
  description = "Rahul system";

  inputs = {
    # Nixpkgs source for packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix Darwin for macOS configuration management
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager for user-level package management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Homebrew for integrating Homebrew with Nix
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nix-homebrew
  }: let
    aarch64_darwin_configuration = { pkgs, ... }: {
      # System packages
      environment.systemPackages = [
        pkgs.skhd
        pkgs.yabai
        pkgs.mkalias  # Tool to make APFS aliases, used to link pkgs to Spotlight
      ];

      # Homebrew configuration
      homebrew.enable = true;
      homebrew.casks = [
        # "wireshark"
      ];
      homebrew.brews = [
        "mas"
      ];
      homebrew.masApps = { 
        # <name> = <id> 
        # "Dropover" = 1355679052;
      };

      # Security settings
      security.pam.enableSudoTouchIdAuth = true;

      # Keyboard settings
      system.keyboard.enableKeyMapping = true;
      system.keyboard.remapCapsLockToControl = true;

      # System preferences
      system.defaults.screensaver.askForPasswordDelay = 10;
      system.defaults.dock.autohide = true;
      system.defaults.dock.magnification = true;
      system.defaults.dock.largesize = 60;
      system.defaults.dock.mru-spaces = false;
      system.defaults.screencapture.location = "~/screenshots"; # does not automatically create folder

      # User settings
      users.users.rahulkumar.home = "/Users/rahulkumar";

      # Finder preferences
      system.defaults.finder.FXPreferredViewStyle = "icnv";  # Icon view
      system.defaults.finder.AppleShowAllExtensions = true;
      system.defaults.finder.FXDefaultSearchScope = "SCcf";  # Current folder
      system.defaults.finder._FXSortFoldersFirst = true;     # Default false

      # Menu extra preferences
      system.defaults.menuExtraClock.Show24Hour = true;

      # Text input settings
      system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
      system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
      system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
      system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

      # Nix daemon settings
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;  # Uncomment if you need a specific Nix version

      # Enable experimental features for Nix
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Backwards compatibility
      system.stateVersion = 4;

      # Specify host platform
      nixpkgs.hostPlatform = "aarch64-darwin";
    };

  in {
    # Define darwin configuration for the specified MacBook
    darwinConfigurations."Rahuls-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        aarch64_darwin_configuration
        # Home Manager configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rahulkumar = import ./home.nix;
        }

        # Nix Homebrew configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon: Also install Homebrew under Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "rahulkumar";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set for convenience
    darwinPackages = self.darwinConfigurations."Rahuls-MacBook-Air".pkgs;
  };
}

