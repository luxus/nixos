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
      prettierd
      stylua
      unzip
      vale
      luajitPackages.tiktoken_core
      luajitPackages.luarocks
      gdu
      libgit2
      nodejs_23
      corepack_23
      python313
      playwright
      deno
      nodePackages.jsonlint
      selene
      #NOTE:most of the time out of date, using uv package instead
      # aider-chat
      ripgrep
      tree-sitter
      nixd
      nixfmt-rfc-style
      zig
      gcc
      uv
      imagemagick
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
