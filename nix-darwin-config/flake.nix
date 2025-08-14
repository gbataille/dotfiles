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

    configuration = { pkgs, lib, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = pkgListFn { inherit pkgs; } ;

      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "1password-cli"
      ];

      # environment.variables.FOO = "BAR";

      environment.shellAliases.cdp = "cd ~/Documents/Prog";

      # Auto upgrade nix package and the daemon service.
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;
      programs.zsh.enableCompletion = true;
      programs.zsh.enableFzfCompletion = true;
      programs.zsh.enableFzfHistory = true;
      programs.zsh.enableSyntaxHighlighting = true;

      programs.direnv.enable = true;

      # Sudo with touchId
      security.pam.services.sudo_local.touchIdAuth = true;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system.primaryUser = "gbataille";
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      system.defaults.finder.AppleShowAllExtensions = true;
      system.defaults.finder.FXPreferredViewStyle = "clmv";
      system.defaults.finder.ShowPathbar = true;

      system.defaults.screensaver.askForPasswordDelay = 5;

      system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
      system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
      # 120, 90, 60, 30, 12, 6, 2
      system.defaults.NSGlobalDomain.KeyRepeat = 2;
      # 120, 94, 68, 35, 25, 15
      system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
      system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
      system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
      system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
      system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;

      system.defaults.dock.appswitcher-all-displays = true;
      system.defaults.dock.autohide = true;
      system.defaults.dock.mru-spaces = false;

      system.defaults.trackpad.Clicking = true;
      system.defaults.trackpad.TrackpadRightClick = true;
      system.defaults.trackpad.TrackpadThreeFingerDrag = true;

      system.keyboard.enableKeyMapping = true;
      system.keyboard.remapCapsLockToControl = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake . (if the configuration has the name of the machine hostname)
    # $ darwin-rebuild build --flake .#simple (if the config has the name "simple")
    darwinConfigurations.GregM3Pro = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.GregM3Pro.pkgs;
  };
}
