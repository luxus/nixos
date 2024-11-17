{ pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };
  hardware.video.hidpi.enable = lib.mkDefault true;
  # services.xserver.dpi = 192;

  environment.systemPackages =
    with pkgs;
    [
    ];
}
