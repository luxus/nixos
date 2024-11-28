{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim-nightly;
  };
  home = {
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    packages = with pkgs; [
      # jdk22
      go
      unzip
      vale
      luajitPackages.tiktoken_core
      luajitPackages.luarocks
      gdu
      libgit2
      nodejs_23
      # python3
      deno
      nodePackages.jsonlint
      selene
      aider-chat
      ripgrep
      tree-sitter
      nixd
      zig
      gcc
    ];
  };

  # xdg.configFile."nvim" = {
  #   source = sources.astronvim.src;
  #   recursive = true;
  # };

  # xdg.configFile."nvim/lua/user" = {
  #   source = globals.root + /static/configs/astronvim;
  #   recursive = true;
  # };
}
