{ flake, pkgs, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia-ada-lovelace
    # inputs.nixos-hardware.nixosModules.common-gpu
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-pc

    ./configuration.nix
    (self + /modules/nixos/linux/gui/hyprland)
    (self + /modules/nixos/linux/gui/gnome.nix)
    (self + /modules/nixos/linux/gui/desktopish/fonts.nix)
    (self + /modules/nixos/linux/gui/desktopish/kanata.nix)
    (self + /modules/nixos/linux/gui/desktopish/steam.nix)
    (self + /modules/nixos/linux/gui/_1password.nix)
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  programs.nix-ld.enable = true; # for vscode server

  environment.systemPackages = with pkgs; [
    vscode
    vivaldi
    zed-editor
  ];

  hardware.i2c.enable = true;
  hardware.uinput.enable = true;

  # Workaround the annoying `Failed to start Network Manager Wait Online` error on switch.
  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
