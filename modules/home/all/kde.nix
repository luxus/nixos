{ pkgs, flake, ... }:
{
  imports = [
    flake.inputs.plasma-manager.homeManagerModules.plasma-manager
  ];
  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Mountain/contents/images_dark/5120x2880.png";
    };
    kwin = {
      virtualDesktops.number = 6;
      nightLight = {
        enable = true;
        location = {
          latitude = "47.57347571147302";
          longitude = "8.516919680627781";
        };
        mode = "location";
        temperature = {
          day = 6500;
          night = 4200;
        };
      };
    };
    shortcuts = {
      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Window to Desktop 1" = "Meta+Shift+1";
        "Window to Desktop 2" = "Meta+Shift+2";
        "Window to Desktop 3" = "Meta+Shift+3";
        "Window to Desktop 4" = "Meta+Shift+4";
        "Window to Desktop 5" = "Meta+Shift+5";
        "Window to Desktop 6" = "Meta+Shift+6";
        "Show Desktop" = "none";
      };
    };
    spectacle.shortcuts.launch = "Print";
    hotkeys.commands."launch-ghostty" = {
      name = "Launch ghostty";
      key = "Meta+Return";
      command = "ghostty";
    };
    hotkeys.commands."launch-krunner" = {
      name = "Launch krunner";
      key = "Meta+D";
      command = "krunner";
    };
    configFile = {
      baloofilerc."Basic Settings".Indexing-Enabled.value = false;
      kwinrc.Plugins.krohnkiteEnabled = true;
    };
    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay = {
          enable = true;
          idleTimeout = 300;
        };

        whenLaptopLidClosed = "sleep";
        inhibitLidActionWhenExternalMonitorConnected = true;

        turnOffDisplay = {
          idleTimeout = 600;
          idleTimeoutWhenLocked = 120;
        };
      };
      battery = {
        autoSuspend.action = "sleep";
        dimDisplay = {
          enable = true;
          idleTimeout = 120;
        };

        whenLaptopLidClosed = "sleep";
        inhibitLidActionWhenExternalMonitorConnected = true;

        turnOffDisplay = {
          idleTimeout = 300;
          idleTimeoutWhenLocked = 60;
        };
      };
      general.pausePlayersOnSuspend = true;
    };
  };
}
