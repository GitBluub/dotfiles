{
  description = "Example Darwin system flake";

  inputs = {
  # bitwarden-cli has a build issue on macOS since 2024.8.0:
  # this commit fixes nixpkgs right before switching to 2024.8.0
  # https://github.com/NixOS/nixpkgs/issues/339576
    nixpkgs.url = "github:nixos/nixpkgs/c374d94f1536013ca8e92341b540eba4c22f9c62";
  #inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    nikitabobko = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      flake = true;
    };

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, nikitabobko, apple-fonts }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages =
        [ pkgs.neovim
          pkgs.tmux
          pkgs.nix-index
          pkgs.discord
          pkgs.oh-my-zsh
          pkgs.starship
          pkgs.git
          pkgs.stow
          pkgs.gh
          pkgs.atuin
          pkgs.kubectl
          pkgs.kubectx
          pkgs.nodejs_20
          pkgs.node-gyp
          pkgs.bitwarden-cli
          pkgs.go
          pkgs.gnupg
          pkgs.krew
          pkgs.kubernetes-helm
          pkgs.kubernetes-helmPlugins.helm-diff
          pkgs.k9s
          pkgs.kubeseal
          pkgs.youtube-music
          pkgs.sketchybar
          pkgs.jankyborders
        ];

      fonts.packages = [
        inputs.apple-fonts.packages.${pkgs.system}.sf-pro
        inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
      ];

      homebrew = {
        enable = true;
        casks = [
          #"aerospace"
          "bitwarden"
          "nikitabobko/tap/aerospace"
        ];
        brews= [
# All package you want to install with brew
        ];

        masApps = {
# All package you want to install from the AppStore
# "Yoink" = <insert id>
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in 
       pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
    '';

# Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
# nix.package = pkgs.nix;

# Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

# Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
# programs.fish.enable = true;

# Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

# Used for backwards compatibility, please read the changelog before changing.
# $ darwin-rebuild changelog
      system.stateVersion = 5;

# The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      users.users.lauzuret.home = "/Users/lauzuret";
    };
  in
  {
    darwinConfigurations."lauzuret-mac" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.users.lauzuret = import ./home.nix;
          # home-manager.useUserPackages = true;
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # existing homebrew install
            autoMigrate = true;
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "lauzuret";

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
              "nikitabobko/tap" = nikitabobko;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."lauzuret-mac".pkgs;
  };
}
