# Configuration common to all Linux systems
{ flake, ... }:

let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  imports = [
    {
      users.users.${config.me.username} = {
        isNormalUser = true;
        hashedPassword = "$6$sZU9yfCR0qIEOegs$KprZkpYZD3/8VH50MHZSbaKITLW4tOVBJzri9P9TyCZ3lvqRACgXsghjRqb8KE5a1GHD4I6dFZdxCTKKUZP5e.";
      };
      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        #FIX: macos is a differnt folder
        flake = "/home/luxus/projects/nixos";
      };
      home-manager.users.${config.me.username} = { };
      home-manager.backupFileExtension = "backup3s";
      home-manager.sharedModules = [
        self.homeModules.default
        self.homeModules.linux-only
      ];
    }
    self.nixosModules.common
    inputs.ragenix.nixosModules.default # Used in github-runner.nix & hedgedoc.nix
    ./linux/self-ide.nix
    ./linux/current-location.nix
  ];
}
