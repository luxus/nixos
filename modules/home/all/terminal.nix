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
      sd
      wget
      moreutils # ts, etc.
      gnumake
      killall
      lolcat
      # Broken, https://github.com/NixOS/nixpkgs/issues/299680
      # ncdu

      # Useful for Nix development
      ci
      touchpr
      cargo
      omnix
      nixpkgs-fmt
      nurl
      just
      lla
      mosh
      gping
      prettyping
      zellij
      devenv
      jj
      # ghostty
      # lazyjj
      # broken on mac
      # monolith

      # Publishing
      asciinema
      # twitter-convert

      # # Dev
      fuckport
      sshuttle-via
      entr
      git-merge-and-delete
      hub
      google-cloud-sdk
      dwt1-shell-color-scripts

      # # Fonts
      lsof
      rustscan
      gnupg
      tree
      nmap
      # new tools
      du-dust
      gdu
      rclone
      w3m
      ast-grep
      mediainfo
      chafa
      odt2txt
      # # spotify-player
      pueue
      zenith
      croc
      rsync
      wget
      eternal-terminal
      ouch
      nettools
      doggo
      duf
      gitu
      twitch-tui

      # # Nix dev
      cachix
      nil # Nix language server
      nix-info
      nixpkgs-fmt
      nixfmt-rfc-style
      nixpkgs-review
      nix-tree
      nixd

      # # Dev
      tmate
      quarto
      typst

    ];
  };

  fonts.fontconfig.enable = true;

  programs = {
    nix-index = {
      enable = true;
    };
    gitui = {
      enable = true;
      theme = ''
        (
          selected_tab: Rgb(254,172,208), // magenta #feacd0
          command_fg: Rgb(152,152,152), // comment #989898
          selection_bg: Rgb(112,48,175), // visual #7030af
          selection_fg: Rgb(255,255,255), // fg_main #ffffff
          cmdbar_bg: Rgb(0,0,0), // bg_main #000000
          cmdbar_extra_lines_bg: Rgb(0,0,0), // bg_main #000000
          disabled_fg: Rgb(152,152,152), // comment #989898
          diff_line_add: Rgb(160,224,160), // fg_added #a0e0a0
          diff_line_delete: Rgb(255,191,191), // fg_removed #ffbfbf
          diff_file_added: Rgb(160,224,160), // fg_added #a0e0a0
          diff_file_removed: Rgb(255,191,191), // fg_removed #ffbfbf
          diff_file_moved: Rgb(202,166,223), // magenta_faint #caa6df
          diff_file_modified: Rgb(239,239,128), // fg_changed #efef80
          commit_hash: Rgb(202,166,223), // magenta_faint #caa6df
          commit_time: Rgb(106,228,185), // cyan_cooler #6ae4b9
          commit_author: Rgb(68,188,68), // green #44bc44
          danger_fg: Rgb(255,95,89), // red #ff5f59
          push_gauge_bg: Rgb(0,0,0), // bg_main #000000
          push_gauge_fg: Rgb(255,255,255), // fg_main #ffffff
          tag_fg: Rgb(247,143,231), // magenta_warmer #f78fe7
          branch_fg: Rgb(208,188,0), // yellow #d0bc00
        )
      '';
    };
    nix-index-database.comma.enable = true;
    zoxide.enable = true;
    bottom = {
      enable = true;
    };
    skim = {
      enable = true;
    };
    ripgrep.enable = true;

    # Better `cat`
    bat = {
      enable = false;
      extraPackages = with pkgs.bat-extras; [
        batdiff
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
    carapace.enable = true;
    thefuck = {
      enable = true;
      # enableInstantMode = false;
    };
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
      icons = "auto";
      git = true;
    };
  };
}
