{
  description = "Example Darwin system flake";

  inputs = {
  # bitwarden-cli has a build issue on macOS since 2024.8.0:
  # this commit fixes nixpkgs right before switching to 2024.8.0
  # https://github.com/NixOS/nixpkgs/issues/339576
  #nixpkgs.url = "github:nixos/nixpkgs/c374d94f1536013ca8e92341b540eba4c22f9c62";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # x86_64-darwin was dropped in nixpkgs 26.11; hunk's treefmt outputs still eval it.
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    brew-src = {
      url = "github:Homebrew/brew/7.0.8";
      flake = false;
    };
    nix-homebrew.inputs.brew-src.follows = "brew-src";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lazyvim.url = "github:pfassina/lazyvim-nix";
    lazyvim.inputs.nixpkgs.follows = "nixpkgs";
    hunk = {
      url = "github:modem-dev/hunk";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

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

    morantron = {
      url = "github:morantron/homebrew-tmux-fingers";
      flake = false;
    };

    # apple-fonts = {
    #   url = "github:Lyndeno/apple-fonts.nix";
    #   flake = true;
    # };

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, lazyvim, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, nikitabobko, morantron, hunk, ... }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      nixpkgs.config.allowUnfree = true;

      # vscode 1.129.1 darwin build is broken in nixpkgs 26.11 (patchPhase can't find
      # @vscode/ripgrep-universal rg). Source it from 26.05 stable (1.119.0) instead.
      nixpkgs.overlays = [
        (final: prev: {
          vscode = (import inputs.nixpkgs-darwin {
            inherit (prev) system;
            config.allowUnfree = true;
          }).vscode;
        })
        # atuin 18.23.0 e2e tests fail in unsandboxed darwin builds; fixed upstream in
        # https://github.com/NixOS/nixpkgs/pull/574509, not yet in the pinned nixos-unstable rev.
        (final: prev: {
          atuin = prev.atuin.overrideAttrs (old: {
            env = (old.env or { }) // {
              ATUIN_E2E_BASH = prev.lib.getExe (
                prev.writeShellScriptBin "bash" ''
                  NOSYSBASHRC=1 exec ${prev.lib.getExe prev.bashInteractive} "$@"
                ''
              );
            };
          });
        })
      ];

      environment.systemPackages =
        [ pkgs.neovim
          pkgs.tmux
          pkgs.lazygit
          pkgs.jujutsu
          pkgs.jjui
          pkgs.stow
          pkgs.uv
          pkgs.nix-index
          pkgs.discord
          pkgs.oh-my-zsh
          pkgs.starship
          pkgs.git
          pkgs.ripgrep
          pkgs.fd
          pkgs.vlc-bin
          pkgs.dotnet-sdk_8
          pkgs.stow
          pkgs.gh
          pkgs.atuin
          pkgs.kubectl
          pkgs.kubectx
          pkgs.nodejs_24
          pkgs.cargo
          pkgs.node-gyp
          #pkgs.bitwarden-cli
          pkgs.go
          pkgs.vscode
          pkgs.raycast
          pkgs.gnupg
          pkgs.krew
          pkgs.kubelogin-oidc
          pkgs.kubernetes-helm
          pkgs.kubernetes-helmPlugins.helm-diff
          pkgs.k9s
          (pkgs.azure-cli.withExtensions [ pkgs.azure-cli-extensions.support ])
          pkgs.opencode
          pkgs.claude-code
          pkgs.pi-coding-agent

          pkgs.opentofu
          pkgs.argocd
          pkgs.kubeseal
          pkgs.talosctl
          pkgs.jq
          pkgs.yq-go
          pkgs.docker
          pkgs.colima
          pkgs.pear-desktop
          pkgs.sketchybar
          pkgs.jankyborders
          pkgs.ghostty-bin
          pkgs.aerospace
          #pkgs.nyxt
          #

          pkgs.cilium-cli
          pkgs.cmctl
          pkgs.dive
          pkgs.helm-docs
          pkgs.kubecm
          pkgs.lazysql
          pkgs.mkcert
          pkgs.openssh
          pkgs.sqlcmd
          pkgs.stern
          pkgs.usql
          pkgs.talhelper
          pkgs.sops
          pkgs.age

          pkgs.bun
          # lsps
          pkgs.helm-ls
          pkgs.gopls
        ];

      # fonts.packages = [
      #   inputs.apple-fonts.packages.${pkgs.system}.sf-pro
      #   inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
      # ];

      homebrew = {
        enable = true;
        casks = [
          #"aerospace"
          #"bitwarden"
          #"nikitabobko/tap/aerospace"
          "multipass"
        ];
        brews= [
          "podman"
          "bitwarden-cli"
          "morantron/tmux-fingers/tmux-fingers"
          "mole"
# All package you want to install with brew
        ];

        masApps = {
# All package you want to install from the AppStore
# "Yoink" = <insert id>
        };
        taps = builtins.attrNames config.nix-homebrew.taps; 
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.primaryUser = "lauzuret";
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = [ "/Applications" ];
        };
      in 
       pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
    '';

# Auto upgrade nix package and the daemon service.
  nix.enable = true;
      #services.nix-daemon.enable = true;
# nix.package = pkgs.nix;

# Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.optimise.automatic = true;
      nix.gc = { automatic = true; options = "--delete-older-than 14d"; };

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
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.lauzuret = import ./home.nix;
          # home-manager.useUserPackages = true;
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # existing homebrew install
            #autoMigrate = true;
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
              "morantron/tmux-fingers" = morantron;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."lauzuret-mac".pkgs;
  };
}
