{
  pkgs,
  flake,
  lib,
  ...
}:
{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      wayland.compositor = "kwin";
    };
    desktopManager.plasma6.enable = true;
  };
  # services.xserver.dpi = 192;

  environment.systemPackages = with pkgs; [
    kdePackages.qtwayland
    kdePackages.krohnkite
    # neovide
    # krohnkite
    (vivaldi.overrideAttrs (oldAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
    }))
  ];
}
