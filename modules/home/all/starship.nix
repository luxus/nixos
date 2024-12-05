{ pkgs, ... }:
let
  settings = pkgs.lib.importTOML ./starship.toml;
in
{
  programs.starship = {
    enable = true;
    # presets = [ "jetpack" ];
    # enableTransience = true;
    # settings = {
    #   username = {
    #     style_user = "blue bold";
    #     style_root = "red bold";
    #     format = "[$user]($style) ";
    #     disabled = false;
    #     show_always = true;
    #   };
    #   hostname = {
    #     ssh_only = false;
    #     ssh_symbol = "🌐 ";
    #     format = "on [$hostname](bold red) ";
    #     trim_at = ".local";
    #     disabled = false;
    #   };
    # };
    settings = settings;
  };
}
