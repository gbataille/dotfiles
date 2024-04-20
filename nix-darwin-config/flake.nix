{
  description = "GBA's system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    pkgListFn = import ./systemPkgs.nix;
    aliases = import ./aliases.nix;

    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = pkgListFn { inherit pkgs; } ;
      environment.shellAliases = {
        cdp = "cd ~/Documents/Prog/";
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableFzfCompletion = true;
        enableFzfHistory = true;
        enableSyntaxHighlighting = true;
      };
      # programs.fish.enable = true;

      programs.direnv = {
        enable = true;
      };

      # Sudo with touchId
      security.pam.enableSudoTouchIdAuth = true;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system = {
        # Set Git commit hash for darwin-version.
        configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        stateVersion = 4;

        defaults = {
          finder = {
            AppleShowAllExtensions = true;
            FXPreferredViewStyle = "clmv";
            ShowPathbar = true;
          };

          screensaver = {
            askForPasswordDelay = 5;
          };

          NSGlobalDomain = {
            AppleShowAllFiles = true;
            AppleKeyboardUIMode = 3;
            InitialKeyRepeat = 500;
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;
            "com.apple.keyboard.fnState" = true;
            "com.apple.mouse.tapBehavior" = 1;
          };

          dock = {
            appswitcher-all-displays = true;
            autohide = true;
            mru-spaces = false;
          };

          trackpad = {
            Clicking = true;
            TrackpadRightClick = true;
            TrackpadThreeFingerDrag = true;
          };

        };
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToControl = true;
        };
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations.GregM3Pro = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.GregM3Pro.pkgs;
  };
}
