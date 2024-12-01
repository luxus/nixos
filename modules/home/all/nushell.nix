{
  pkgs,
  lib,
  config,
  ...
}:
{

  programs.nushell = {
    enable = true;
    environmentVariables = {
      PROMPT_INDICATOR_VI_INSERT = "󰞷 ";
      PROMPT_INDICATOR_VI_NORMAL = " ";
      FZF_DEFAULT_COMMAND = "fd --color=always --type file --hidden --exclude node_modules --exclude .git";
      SKIM_DEFAULT_COMMAND = "$env.FZF_DEFAULT_COMMAND";
      # Because, adding it in .ssh/config is not enough.
      # cf. https://developer.1password.com/docs/ssh/get-started#step-4-configure-your-ssh-or-git-client
      SSH_AUTH_SOCK = lib.mkIf pkgs.stdenv.isDarwin "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };
    extraEnv = # nu
      ''
        $env.PATH = (
          $env.PATH
          | split row (char esep)
          | prepend $"/etc/profiles/per-user/($env.USER)/bin"
          | prepend '/run/current-system/sw/bin/'
          | prepend '/Applications/Docker.app/Contents/Resources/bin/'
        )

      '';
    extraConfig = # nu
      ''
        $env.config = {
          show_banner: false
          use_kitty_protocol: true

          edit_mode: vi
          cursor_shape: {
            vi_insert: line
            vi_normal: underscore
          }
        }
        def nsdc [
          before: path = /run/booted-system
          after: path = /run/current-system
          ]: nothing -> table {
            ^nix store diff-closures $before $after
            | lines
            | parse -r '^(?<pkg>[\w\.-]+): ?(?:(?<before>.+) → (?<after>.+?)),?? ?(?<size>[+-][\d\.]+ KiB)?$'
            | update before { str replace -a ", " "\n" }
            | update after  { str replace -a ", " "\n" } 
            | rename -c {before: ($before | path basename), after: ($after | path basename)}
            | update size {|row| if ($row.size | is-empty) {"0 B"} else {$row.size}} | into filesize size
        }
        plugin add ${pkgs.nushellPlugins.gstat}/bin/nu_plugin_gstat
        plugin add ${pkgs.nushellPlugins.skim}/bin/nu_plugin_skim
        plugin add ${pkgs.nushellPlugins.formats}/bin/nu_plugin_formats
        plugin add ${pkgs.nushellPlugins.query}/bin/nu_plugin_query
        #Fix: not updated yet
        # plugin add ${pkgs.nushellPlugins.units}/bin/nu_plugin_units
        # plugin add ${pkgs.nushellPlugins.net}/bin/nu_plugin_net
        # plugin add ${pkgs.nushellPlugins.highlight}/bin/nu_plugin_highlight

        plugin use skim
        plugin use gstat
        plugin use formats
        plugin use query
        # plugin use units
        # plugin use net
        # plugin use highlight
      '';
    #configFile.source = ./nushell/config.nu;
    # envFile.source = ./nushell/env.nu;
    # configFile.source = ./nushell/config.nu;
    # extraEnv = (toString (builtins.readFile ./nushell/env.nu));
    inherit (config.home) shellAliases; # Our shell aliases are pretty simple
  };
}
