{
  pkgs,
  lib,
  config,
  ...
}:
{

  programs.nushell = {
    enable = true;
    envFile.source = ./nushell/env.nu;
    configFile.source = ./nushell/config.nu;
    inherit (config.home) shellAliases; # Our shell aliases are pretty simple
    extraEnv = lib.mkIf pkgs.stdenv.isDarwin ''
      # Because, adding it in .ssh/config is not enough.
      # cf. https://developer.1password.com/docs/ssh/get-started#step-4-configure-your-ssh-or-git-client
      export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    '';
  };
}
