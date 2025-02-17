{ pkgs, flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  tunnelID = "f479a774-f37d-4458-9cfd-ff662538dccd";
in
{
  imports = [
    self.nixosModules.default
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia-turing
    # inputs.nixos-hardware.nixosModules.common-gpu-hidpi
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-pc

    ./configuration.nix
    # (self + /modules/nixos/linux/gui/hyprland)
    # (self + /modules/nixos/linux/gui/gnome.nix)
    # (self + /modules/nixos/linux/gui/kde.nix)
    # (self + /modules/nixos/linux/gui/desktopish/fonts.nix)
    # (self + /modules/nixos/linux/gui/_1password.nix)
  ];
  services.open-webui = {
    enable = false;
    openFirewall = true;
    port = 8080;
    host = "0.0.0.0";
    environment = {
      OLLAMA_API_BASE_URL = "http://192.168.178.71:11434";
      # Disable authentication
      # WEBUI_AUTH = "False";
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
    };
  };
  services.paperless = {
    enable = true;
    consumptionDirIsPublic = true;
    address = "pl.luxus.ai";
    settings = {
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        ".DS_STORE/*"
        "desktop.ini"
      ];
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
      PAPERLESS_OCR_USER_ARGS = {
        optimize = 1;
        pdfa_image_compression = "lossless";
      };
    };
  };

  # Enable the OpenSSH daemon.
  services = {
    ollama = {
      enable = true;
      # port = 8081;
      host = "0.0.0.0";
      openFirewall = true;
    };
    openssh = {
      enable = true;
      openFirewall = true;
    };
    cloudflared = {
      enable = true;
      tunnels = {
        ${tunnelID} = {
          credentialsFile = "/etc/cloudflared/${tunnelID}.json";
          default = "http_status:404";
          ingress = {
            "gen.luxus.ai" = "http://localhost:8080";
            "pl.luxus.ai" = "http://localhost:8080";
          };
        };
      };
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      8080
      8188
      28981
      3000
    ];
  };
  services.immich = {
    enable = false;
    openFirewall = true;
  };
  services.forgejo = {
    enable = true;
    package = pkgs.forgejo;
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
  programs.nix-ld.enable = true; # for vscode server

  environment.systemPackages = with pkgs; [
    cudatoolkit
  ];
  hardware.i2c.enable = true;

  # Workaround the annoying `Failed to start Network Manager Wait Online` error on switch.
  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
