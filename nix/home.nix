{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./lazyvim.nix
    inputs.hunk.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  #home.username = "lauzuret";
  #home.homeDirectory = "/Users/lauzuret";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # environment.shells = with pkgs; [zsh];
  home.packages = with pkgs;
    [
      eza
      htop-vim
      tldr
      fd
      duf
      ncdu
      ripgrep
      fzf
      nix-your-shell
      unzip
      zip
      bc
      glow
      gh
    ];


  programs.hunk = {
    enable = true;
    enableGitIntegration = true; # Optional: set hunk as default git pager
    settings = {
      vcs = "jj";
      theme = "graphite";
      mode = "split";
      line_numbers = true;
    };
  };

  programs.atuin = {
    enable = true;
    settings = {
      update_check = false;
      show_preview = true;
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "GitBluub";
        email = "louis.auzuret@gmail.com";
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };
    };
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      experimental = true;
      verbose = false;
      auto_install = true;
      github.credential_command = "gh auth token";
    };

  };

  programs.command-not-found.enable = false;
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.less.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      format = lib.concatStrings [
        "--"
        "$status"
        "$cmd_duration"
        "$nix_shell"
        "$fill"
        "$line_break"
        "$hostname"
        "$python"
        "$directory"
        "[(\\($git_branch$git_commit$git_status$git_state\\) )](green)"
        "$kubernetes"
        "$character"
      ];

      fill = {
        symbol = "-";
        style = "fg:#808080";
      };

      directory = {
        truncate_to_repo = false;
        fish_style_pwd_dir_length = 1;
        style = "bold fg:#00AFFF";
      };

      git_branch = {
        format = "([($branch(: $remote_branch))]($style))";
        only_attached = true;
        style = "green";
      };

      git_commit = {
        format = "[($hash$tag)]($style)";
        style = "green";
        only_detached = true;
        tag_disabled = false;
        tag_symbol = "tag:";
      };

      kubernetes = {
          disabled = false;
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        style = "yellow";
        ahead = " +$count";
        behind = " -$count";
        diverged = "";
        conflicted = " =$count";
        untracked = " ?$count";
        stashed = " *$count";
        modified = " !$count";
        staged = " +$count";
        deleted = "";
        renamed = "";
      };

      git_state = {
        format = "( [$state( $progress_current/$progress_total)]($style))";
      };

      status = {
        format = " [($symbol($signal_name )$status)]($style)";
        pipestatus_format = "[$symbol$pipestatus]($style)";
        pipestatus_segment_format = "[($signal_name )$status]($style)";
        symbol = "x";
        pipestatus = true;
        disabled = false;
      };

      cmd_duration = {
        format = " [ $duration]($style)";
      };

      jobs = {
        symbol = "jobs:";
        format = " [$symbol$number]($style)";
      };

      python = {
        format = "[( \($virtualenv\))]($style)";
      };

      nix_shell = {
        format = "[\( $name\) nix]($style)";
        style = "cyan";
        heuristic = true;
      };

      hostname = {
        format = "[ $ssh_symbol$hostname]($style)";
        ssh_symbol = "ssh:";
      };

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[x](bold red)";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      # kubec
      k = "kubectl";
      kg = "kubectl get";
      ke = "kubectl exec";

      # ls/exa stuff
      l = "ls -l";
      ll = "ls -l";
      la = "ls -la";
      lla = "ls -la";
      lc = "l --color";
      exa = "eza --group";
      lg = "exa -l --git-ignore";
      ls = "exa";
      lt = "exa --tree";
      tree = "exa --tree";

      # git stuff
      g = "git";
      gs = "git status";
      gl = "git log";
      gu = "git pull";
      gcam = "git commit --amend";
      gcamn = "git commit --amend --no-edit";
      gco = "git checkout";

      # Misc
      dc = "docker-compose";
      dcd = "docker-compose -f docker-compose.dev.yml";
      t = "tmux";
      op = "xdg-open";
      n = "nvim";
      vim = "nvim";
      v = "nvim";
    };
    shellGlobalAliases = {
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
      "......" = "../../../../..";
    };

    plugins = [
      {
        name = "you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
      {
        name = "sudo";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/sudo/sudo.plugin.zsh";
      }
      {
        name = "git";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/git/git.plugin.zsh";
      }
      {
        name = "clipcopy"; # dependency of copypath & copyfile
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/lib/clipboard.zsh";
      }
      {
        name = "copypath";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/copypath/copypath.plugin.zsh";
      }
      {
        name = "copyfile";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/copyfile/copyfile.plugin.zsh";
      }
    ];
    initExtra = ''
bindkey -e
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

    
export VISUAL="nvim"
export EDITOR="nvim"
export NPM_PACKAGES="$HOME/.npm-global"
export XDG_CACHE_HOME="$HOME/.cache"
export TMUX_FZF_SESSION_FORMAT="#{session_windows} windows"
path+=/opt/homebrew/bin
path+=$NPM_PACKAGES/bin
path+=$HOME/bin
path+=$HOME/.config/rofi/bin
path+=$HOME/.ghcup/bin
path+=$HOME/.local/bin
path+=$HOME/go/bin
path+=''${KREW_ROOT:-$HOME/.krew}/bin
export PATH

ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_USE_ASYNC=false
source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"


    '';

    # zprof.enable = true;
    completionInit =
      #bash
      ''
        # The globbing is a little complicated here:
        # - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
        # - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
        # - '.' matches "regular files"
        # - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.autoload -Uz compinit
        autoload -Uz compinit

        if [[ -n $ZSH_CACHE_DIR/.zcompdump(#qN.mh+24) ]]; then
          compinit;
        else
          compinit -C;
        fi;
      '';
    envExtra = ''
      setopt no_global_rcs
    '';

    sessionVariables = {
      YSU_MESSAGE_FORMAT = "Alias: %alias - %command";
      YSU_IGNORED_ALIASES = ''("g" "-" "~" "/" ".." "..." "...." "....." "md" "rd")'';
      DIRENV_LOG_FORMAT = "";
      WORDCHARS = "_-*";
      T3CODE_TELEMETRY_ENABLED = "false";
      T3CODE_OTEL_SDK_DISABLED = "true";
    };

  };
}
