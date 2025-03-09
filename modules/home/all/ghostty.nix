{
  lib,
  pkgs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;
    installBatSyntax = lib.mkIf pkgs.stdenv.isDarwin false;
    # installVimSyntax = true;
    # clearDefaultKeybindings = true;
    settings = {
      keybind = [
        "super+c=copy_to_clipboard"
        "global:alt+enter=toggle_quick_terminal"
        "super+shift+h=goto_split:left"
        "super+shift+j=goto_split:bottom"
        "super+shift+k=goto_split:top"
        "super+shift+l=goto_split:right"
      ];
      font-family = "MonoLisa";
      font-style = "Medium";
      font-style-italic = "Medium Italic";
      font-size = 14;
      font-feature = [
        "zero"
        "calt"
        "liga"
        "ss01"
        "ss02"
        "ss03"
        "ss05"
        "ss18"
        "ss07"
        "ss08"
        "ss09"
        "ss11"
        "ss15"
        "ss16"
        "ss17"
      ];
      background-opacity = 0.8;
      macos-titlebar-style = "hidden";
      alpha-blending = "linear";

      # confirm-close-surface = false;
      macos-window-shadow = false;
      copy-on-select = false;
      cursor-style-blink = true;
      # cursor-style = "block";
      background-blur-radius = 0;
      unfocused-split-opacity = 0.6;
      # minimum-contrast = 1.1;
      macos-non-native-fullscreen = false;
      macos-option-as-alt = "left";
      # term = "xterm-kitty";
      theme = "dark:kanagawa-paper-ink,light:kanagawa-paper-canvas";
      # window-decoration = lib.mkIf pkgs.stdenv.isLinux false;
      # window-decoration = "auto";
      clipboard-paste-protection = false;
      # window-padding-x = terminal.padding;
      # window-padding-y = terminal.padding;
      # mouse-hide-while-typing = true;

      # quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "2h";
    };
    themes = {
      "kanagawa-paper-canvas" = {
        palette = [
          "0=#393836" # sumiInk5
          "1=#c4746e" # autumnRed
          "2=#699469" # autumnGreen
          "3=#c4b28a" # boatYellow2
          "4=#435965" # dragonBlue
          "5=#a292a3" # dragonPink
          "6=#8ea49e" # waveAqua1
          "7=#c8c093" # oldWhite
          "8=#aca9a4" # dragonWhite
          "9=#cc928e" # surimiOrange
          "10=#72a072" # dragonGreen
          "11=#d4c196" # carpYellow
          "12=#698a9b" # crystalBlue
          "13=#b4a7b5" # oniViolet
          "14=#96ada7" # waveAqua2
          "15=#d5cd9d" # fujiWhite
        ];
        background = "#dcd7ba";
        foreground = "#1f1f28";
        "cursor-color" = "#c4b28a";
        "selection-background" = "#c4b9a2";
        "selection-foreground" = "#393836";
      };
      "kanagawa-paper-ink" = {
        palette = [
          "0=#393836" # sumiInk5
          "1=#c4746e" # autumnRed
          "2=#699469" # autumnGreen
          "3=#c4b28a" # boatYellow2
          "4=#435965" # dragonBlue
          "5=#a292a3" # dragonPink
          "6=#8ea49e" # waveAqua1
          "7=#c8c093" # oldWhite
          "8=#aca9a4" # dragonWhite
          "9=#cc928e" # surimiOrange
          "10=#72a072" # dragonGreen
          "11=#d4c196" # carpYellow
          "12=#698a9b" # crystalBlue
          "13=#b4a7b5" # oniViolet
          "14=#96ada7" # waveAqua2
          "15=#d5cd9d" # fujiWhite
        ];
        background = "#1f1f28";
        foreground = "#dcd7ba";
        "cursor-color" = "#c4b28a";
        "selection-background" = "#766b90";
        "selection-foreground" = "#9e9b93";
      };
    };
  };
}
