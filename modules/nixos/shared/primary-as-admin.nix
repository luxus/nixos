# Make flake.config.peope.myself the admin of the machine
{
  flake,
  pkgs,
  lib,
  ...
}:

{
  # Login via SSH with mmy SSH key
  users.users =
    let
      me = flake.config.me;
      myKeys = [ me.sshKey ];
    in
    {
      root.openssh.authorizedKeys.keys = myKeys;
      # root.extraGroups = [ "uinput" ];
      ${me.username} =
        {
          openssh.authorizedKeys.keys = myKeys;
          shell = pkgs.nushell;
        }
        // lib.optionalAttrs pkgs.stdenv.isLinux {
          isNormalUser = true;
          extraGroups = [
            "video"
            "networkmanager"
            "wheel"
            "uinput"
          ];
        };
    };

  # programs.zsh.enable = lib.mkIf pkgs.stdenv.isLinux true;
  # programs.nushell.enable = lib.mkIf pkgs.stdenv.isLinux true;

  # Make me a sudoer without password
  security = lib.optionalAttrs pkgs.stdenv.isLinux {
    sudo.execWheelOnly = true;
    sudo.wheelNeedsPassword = false;
  };
}
