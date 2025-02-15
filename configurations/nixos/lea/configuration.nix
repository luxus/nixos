{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10; # Keep only the last 10 generations
      consoleMode = "auto";
      extraInstallCommands = ''
        default_cfg=$(${pkgs.coreutils}/bin/cat /boot/loader/loader.conf | ${pkgs.gnugrep}/bin/grep default | ${pkgs.gawk}/bin/awk '{print $2}')
        tmp=$(${pkgs.coreutils}/bin/mktemp -d)

        ${pkgs.coreutils}/bin/echo -ne "$default_cfg\0" | ${pkgs.iconv}/bin/iconv -f utf-8 -t utf-16le > $tmp/efivar.txt

        ${pkgs.efivar}/bin/efivar -n 4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderEntryLastBooted -w -f $tmp/efivar.txt
        ${pkgs.systemd}/bin/bootctl set-default @saved
      '';
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    timeout = 10;
  };
  networking = {
    hostName = "lea"; # Define your hostname.
    networkmanager.enable = true;
  };
  # Select internationalisation properties.

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  programs.mosh = {
    enable = true;
    openFirewall = true;
  };

  security.rtkit.enable = true;
  services.eternal-terminal.enable = true;
  # Enable CUPS to print documents.

  # Enable sound with pipewire.
  services = {
    printing.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  #NOTE: its for nheko
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
