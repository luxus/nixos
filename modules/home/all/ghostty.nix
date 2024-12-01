{
  lib,
  flake,
  pkgs,
  ...
}:
{
  imports = [ flake.inputs.ghostty.homeModules.default ];
  programs.ghostty = {
    enable = true;
    # clearDefaultKeybindings = true;
    keybindings = {
      "super+c" = "copy_to_clipboard";
      "global:alt+enter" = "toggle_quick_terminal";

      "super+shift+h" = "goto_split:left";
      "super+shift+j" = "goto_split:bottom";
      "super+shift+k" = "goto_split:top";
      "super+shift+l" = "goto_split:right";
    };

    package = lib.mkIf pkgs.stdenv.isLinux flake.inputs.ghostty-bin.packages.${pkgs.system}.default;

    settings = {
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
      theme = "dark:neobones_dark,light:neobones_light";
      window-decoration = lib.mkIf pkgs.stdenv.isDarwin true;
      clipboard-paste-protection = false;
      # window-padding-x = terminal.padding;
      # window-padding-y = terminal.padding;
      # mouse-hide-while-typing = true;

      # quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "2h";

      # window-padding-x = 15;
      # window-padding-y = 15;
      #   palette = [
      #     "0=#393b44"
      #     "1=#c94f6d"
      #     "2=#81b29a"
      #     "3=#dbc074"
      #     "4=#719cd6"
      #     "5=#9d79d6"
      #     "6=#63cdcf"
      #     "7=#dfdfe0"
      #     "8=#575860"
      #     "9=#d16983"
      #     "10=#8ebaa4"
      #     "11=#e0c989"
      #     "12=#86abdc"
      #     "13=#baa1e2"
      #     "14=#7ad5d6"
      #     "15=#e4e4e5"
      #   ];
      #   background = "#192330";
      #   foreground = "#cdcecf";
      #   cursor-color = "#cdcecf";
      #   selection-background = "#2b3b51";
      #   selection-foreground = "#cdcecf";
      # };
      # palette = [
      #   "0=#393552"
      #   "1=#eb6f92"
      #   "2=#a3be8c"
      #   "3=#f6c177"
      #   "4=#569fba"
      #   "5=#c4a7e7"
      #   "6=#9ccfd8"
      #   "7=#e0def4"
      #   "8=#47407d"
      #   "9=#f083a2"
      #   "10=#b1d196"
      #   "11=#f9cb8c"
      #   "12=#65b1cd"
      #   "13=#ccb1ed"
      #   "14=#a6dae3"
      #   "15=#e2e0f7"
      #   "16=#ea9a97"
      # ];
      # background = "#000000";
      # foreground = "#e0def4";
      # cursor-color = "#e0def4";
      # selection-background = "#433c59";
      # selection-foreground = "#e0def4";
    };

    keybindings = {
      "super+h" = "goto_split:left";
      "super+l" = "goto_split:right";
      "super+j" = "goto_split:top";
      "super+k" = "goto_split:bottom";

      "page_up" = "scroll_page_fractional:-0.5";
      "page_down" = "scroll_page_fractional:0.5";
    };
  };
}
