# Platform-independent terminal setup
{ flake, pkgs, ... }:

let
  inherit (flake) inputs;
in
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];
  home = {
    shellAliases = {
      e = "nvim";
      g = "git";
      lg = "lazygit";
      l = "ls";
      beep = "say 'beep'";
    };

    #     sessionpath = [
    #   "$home/.local/bin"
    #   "$home/.cargo/bin"
    # ];
    packages = with pkgs; [
      # Unixy tools
      ripgrep
      fd
      sd
      wget
      moreutils # ts, etc.
      gnumake
      killall
      # Broken, https://github.com/NixOS/nixpkgs/issues/299680
      # ncdu

      # Useful for Nix development
      ci
      touchpr
      omnix
      nixpkgs-fmt
      just

      # Publishing
      asciinema
      twitter-convert

      # Dev
      gh
      fuckport
      sshuttle-via
      entr
      git-merge-and-delete

      # Fonts
      cascadia-code
      monaspace

      gnupg
      ripgrep # Better `grep`
      sd
      tree
      nmap
      aria2
      # new tools
      du-dust
      gdu
      jujutsu
      rclone
      rsync
      w3m
      ast-grep
      mediainfo
      odt2txt
      # spotify-player
      pueue
      zenith
      croc
      rsync
      wget
      ouch
      nettools
      doggo
      fastfetch
      duf
      gitu
      devenv
      twitch-tui
      nushellPlugins.skim
      nushellPlugins.gstat
      nushellPlugins.net

      # Nix dev
      cachix
      nil # Nix language server
      nix-info
      nixpkgs-fmt
      nixfmt-rfc-style
      nixpkgs-review
      nix-tree

      # Dev
      tmate

    ];
  };

  fonts.fontconfig.enable = true;

  programs = {
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    nix-index-database.comma.enable = true;
    autojump.enable = false;
    zoxide.enable = true;
    bottom = {
      enable = true;
    };
    skim = {
      enable = true;
    };

    # Better `cat`
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        # batdiff
        batgrep
        batman
        batpipe
        batwatch
        prettybat
      ];
    };

    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow";
      fileWidgetCommand = "fd --type f --hidden --follow";
      defaultOptions = [ "--extended" ];
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      extensions = with pkgs; [
        gh-actions-cache
        gh-cal
        gh-copilot
        gh-dash
        gh-eco
        gh-markdown-preview
      ];
    };
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
    thefuck.enable = true;
    fd.enable = true;
    bun.enable = true;
    # zellij = {
    #   enable = false;
    #   enableBashIntegration = false;
    #   enableZshIntegration = false;
    # };
    yazi = {
      enable = true;
    };
    atuin = {
      enable = true;
      settings = {
        auto_sync = true;
        dialect = "us";
        sync_frequency = "10m";
        sync_address = "https://api.atuin.sh";
        search_mode = "fuzzy"; # 'prefix' | 'fulltext' | 'fuzzy'

        ##: options: 'global' (default) | 'host' | 'session' | 'directory'
        filter_mode = "global";
        filter_mode_shell_up_key_binding = "directory";
      };
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      icons = "auto";
      git = true;
    };
  };
}
