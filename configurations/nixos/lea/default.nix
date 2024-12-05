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
    # inputs.nixos-facter-modules.nixosModules.facter
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
  # config.facter.reportPath = ./hardware.json;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = true;
  };
  services.llama-cpp = {
    enable = false;
    openFirewall = true;
    port = 8088;
    host = "0.0.0.0";
    # packages = [ (pkgs.llama-cpp.override { enableCuda = true; }) ];
    # extraFlags = [ "--slots" ];
    model = "/models/qwen2.5-coder-32b-instruct-q5_0.gguf";
  };
  services.ollama = {
    enable = true;
    # port = 8081;
    host = "0.0.0.0";
    openFirewall = true;
  };
  services.hardware.openrgb.enable = true;
  services.open-webui = {
    enable = true;
    openFirewall = true;
    port = 8080;
    host = "0.0.0.0";
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:8081";
      # Disable authentication
      # WEBUI_AUTH = "False";
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
    };
  };
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  services.cloudflared = {
    enable = true;
    tunnels = {
      "d167a37f-c07b-4444-a0a0-c80a84ebd6ac" = {
        credentialsFile = "/d167a37f-c07b-4444-a0a0-c80a84ebd6ac.json";
        default = "http_status:404";
        ingress = {
          "webui.infoguard.diy" = "http://localhost:8080";
          "flow.infoguard.diy" = "http://localhost:3000";
          "lea.infoguard.diy" = "ssh://localhost:22";
          "leardp.infoguard.diy" = "rdp://localhost:3389";
        };
      };
    };
  };
  # hardware.fancontrol.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      8080
      8081
      3000
      3389
    ];
  };
  programs.nix-ld.enable = true; # for vscode server

  environment.systemPackages = with pkgs; [
    vscode
    vivaldi
    devenv
    zed-editor
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
    lm_sensors
    fan2go
    python312Packages.pydantic

  ];

  hardware.i2c.enable = true;
  hardware.uinput.enable = true;

  # Workaround the annoying `Failed to start Network Manager Wait Online` error on switch.
  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
