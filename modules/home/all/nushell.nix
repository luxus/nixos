{
  pkgs,
  lib,
  config,
  ...
}:
{

  programs.nushell = {
    enable = true;
    environmentVariables = {
      PROMPT_INDICATOR_VI_INSERT = "󰞷 ";
      PROMPT_INDICATOR_VI_NORMAL = " ";
      # Because, adding it in .ssh/config is not enough.
      # cf. https://developer.1password.com/docs/ssh/get-started#step-4-configure-your-ssh-or-git-client
      SSH_AUTH_SOCK = lib.mkIf pkgs.stdenv.isDarwin "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };
    extraLogin = ''
      plugin use skim
      plugin use gstat
      plugin use net
      plugin use highlight
      plugin use formats
      plugin use query
      plugin use units
    '';
    extraConfig = (toString (builtins.readFile ./nushell/config.nu));
    # envFile.source = ./nushell/env.nu;
    # configFile.source = ./nushell/config.nu;
    # extraEnv = (toString (builtins.readFile ./nushell/env.nu));
    inherit (config.home) shellAliases; # Our shell aliases are pretty simple
  };

  home.packages = with pkgs.nushellPlugins; [
    skim
    gstat
    net
    highlight
    formats
    query
    units
  ];
}
