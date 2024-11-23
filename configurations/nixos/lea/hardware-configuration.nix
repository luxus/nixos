# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  nixpkgs-small,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.hostPlatform = "x86_64-linux";
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "nvidia"
    "nvidia_modeset"
    "nvidia_drm"
  ];
  boot.initrd.kernelModules = [ ];
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelPackages = nixpkgs-small.legacyPackages.${pkgs.system}.linuxPackages_latest;
  boot.kernelModules = [
    "nvidia-uvm"
    "kvm-amd"
  ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "nvidia_drm.modeset=1"
    "nvidia_drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "vt.global_cursor_default=0"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "nixos-bgrt";
  boot.plymouth.themePackages = [
    pkgs.nixos-bgrt-plymouth
  ];
  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp102s0u1u3c2.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;
  hardware.graphics = {
    enable32Bit = true;
    enable = true;
    extraPackages32 = with pkgs.driversi686Linux; [
      libvdpau-va-gl
    ];
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };
  hardware.nvidia-container-toolkit.enable = true;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
    open = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  environment.systemPackages = with pkgs; [
    libva
    libvdpau
    vdpauinfo # NOTE: vdpauinfo
    libva-utils # NOTE: vainfo
    vulkan-tools # NOTE: vulkaninfo
    glxinfo # NOTE: glxinfo and eglinfo
    nvtopPackages.full # NOTE: check GPU usage
  ];
  nixpkgs.config.cudaSupport = true;
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia"; # NOTE: hardware acceleration
    VDPAU_DRIVER = "va_gl"; # NOTE: hardware acceleration
    GBM_BACKEND = "nvidia-drm"; # NOTE: wayland buffer api
    WLR_RENDERER = "gles2"; # NOTE: wayland roots compositor renderer
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # NOTE: offload opengl workloads to nvidia

    NVD_BACKEND = "direct"; # NOTE: nvidia-vaapi-driver backend
    __GL_GSYNC_ALLOWED = "1"; # NOTE: nvidia g-sync
    __GL_VRR_ALLOWED = "1"; # NOTE: nvidia g-sync
  };
}
