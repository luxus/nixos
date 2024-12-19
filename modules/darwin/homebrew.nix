{ lib, pkgs, ... }:
{
  environment.systemPath = lib.mkIf pkgs.stdenv.isDarwin [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    masApps = {
      # "Xcode" = 497799835;
      "CrystalFetch" = 6454431289;
      "Parcel" = 639968404;
      "Keynote" = 409183694;
      "NextDNS" = 1464122853;
      "Grocery" = 1195676848;
      "TestFlight" = 899247664;
      "Color Picker" = 1545870783;
      "Apple Configurator" = 1037126344;
      "LINE" = 539883307;
      "Habitify" = 1111447047;
      "Pages" = 409201541;
      "Numbers" = 409203825;
      "Pixelmator Pro" = 1289583905;
    };
    brews = [
      # "folderify" so much deps
      "gnu-sed"
    ];

    # Add taps.
    taps = [
      "buo/cask-upgrade"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/cask"
      "homebrew/command-not-found"
      "homebrew/core"
      "homebrew/services"
      "nikitabobko/tap"
      # "libsql/sqld"
      # "tursodatabase/tap"
    ];

    casks = [
      "aerospace"
      # "kando"
      "whisky"
      "steam"
      # "keycastr"
      "aldente"
      # "superslicer"
      "discord"
      "qlmarkdown"
      # "microsoft-teams"
      # "arc"
      "webstorm"
      "cloudflare-warp"
      "scroll-reverser"
      "zen-browser"
      "arc"
      "burp-suite"
      "raycast"
      "logseq"
      "balenaetcher"
      "1password@beta"
      # "plexamp"
      "utm"
      "gitkraken"
      "orbstack"
      # "cursor"
      "plex"
      # "microsoft-edge@dev"
      "lunar"
      # "visual-studio-code@insiders"
      "sf-symbols"
      "wireshark"
      "iina"
      "tidal"
      "raycast"
      "telegram"
      "insomnia"
      "zed"
      "vivaldi"
      "chatterino"
    ];
  };
}
