{ pkgs, flake, ... }:
{
  home.packages = with pkgs; [
    git-filter-repo
    git-squash # https://github.com/sheerun/git-squash
  ];

  programs.git = {
    # package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = flake.config.me.username;
    userEmail = flake.config.me.email;
    aliases = {
      co = "checkout";
      ci = "commit";
      cia = "commit --amend";
      s = "status";
      st = "status";
      b = "branch";
      # p = "pull --rebase";
      pu = "push";
    };
    iniContent = {
      # Branch with most recent change comes first
      branch.sort = "-committerdate";
      # Remember and auto-resolve merge conflicts
      # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      rerere.enabled = true;
    };
    ignores = [
      "*~"
      "*.swp"
    ];
    lfs.enable = true;
    delta = {
      enable = true;
      options = {
        features = "decorations";
        navigate = true;
        light = false;
        side-by-side = true;
        decorations = {
          minus-style = "syntax '#ffbfbf'";
          minus-non-emph-style = "syntax '#ffbfbf'";
          minus-emph-style = "syntax '#ffbfbf'";
          minus-empty-line-marker-style = "syntax '#ffbfbf'";
          line-numbers-minus-style = "#ffbfbf";
          plus-style = "syntax '#a0e0a0'";
          plus-non-emph-style = "syntax '#a0e0a0'";
          plus-emph-style = "syntax '#a0e0a0'";
          plus-empty-line-marker-style = "syntax '#a0e0a0'";
          line-numbers-plus-style = "#a0e0a0";
          line-numbers-zero-style = "#989898";
        };
      };
    };
    extraConfig = {
      init.defaultBranch = "main"; # Undo breakage due to https://srid.ca/luxury-belief
      core.editor = "nvim";
      #protocol.keybase.allow = "always";
      credential.helper = "store --file ~/.git-credentials";
      pull.rebase = "false";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      # This looks better with the kitty theme.
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [
          "white"
          "bold"
        ];
        inactiveBorderColor = [ "white" ];
        selectedLineBgColor = [
          "reverse"
          "white"
        ];
      };
    };
  };
}
