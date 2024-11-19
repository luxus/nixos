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
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-hidpi

    ./configuration.nix
    (self + /modules/nixos/linux/gui/hyprland)
    # (self + /modules/nixos/linux/gui/gnome.nix)
    (self + /modules/nixos/linux/gui/kde.nix)
    (self + /modules/nixos/linux/gui/desktopish/fonts.nix)
    (self + /modules/nixos/linux/gui/desktopish/kanata.nix)
    (self + /modules/nixos/linux/gui/desktopish/steam.nix)
    (self + /modules/nixos/linux/gui/_1password.nix)
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = true;
  };
  services.llama-cpp = {
    enable = false;
    openFirewall = true;
    port = 8808;
    model = "/models/qwen2.5-coder-32b-instruct-q5_0.gguf";
  };
  services.ollama = {
    enable = true;
    port = 12345;
    acceleration = "cuda";
    openFirewall = true;
  };
  services.open-webui = {
    enable = true;
    openFirewall = true;
    port = 8080;
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:12345";
      # Disable authentication
      # WEBUI_AUTH = "False";
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
    };
  };

  programs.nix-ld.enable = true; # for vscode server

  environment.systemPackages = with pkgs; [
    vscode
    vivaldi
    devenv
    (llama-cpp.override { cudaSupport = true; })

    zed-editor
  ];

  hardware.i2c.enable = true;
  hardware.uinput.enable = true;

  # Workaround the annoying `Failed to start Network Manager Wait Online` error on switch.
  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
