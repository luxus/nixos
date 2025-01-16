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
    extraEnv = lib.mkIf pkgs.stdenv.isDarwin ''
      $env.PATH = (
        $env.PATH
        | split row (char esep)
        | prepend $"/etc/profiles/per-user/($env.USER)/bin"
        | prepend '/run/current-system/sw/bin/'
        | prepend $"/Users/($env.USER)/.local/bin"
        | prepend '/Applications/Docker.app/Contents/Resources/bin/'
      )

    '';
    extraConfig = # nushell
      ''
              $env.LS_COLORS = (${pkgs.vivid}/bin/vivid generate one-light | str trim)
              let carapace_completer = {|spans|
                # if the current command is an alias, get it's expansion
                let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)
                # overwrite
                let spans = (if $expanded_alias != null  {
                  # put the first word of the expanded alias first in the span
                  $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
                } else {
                  $spans
                })
                carapace $spans.0 nushell ...$spans
                | from json
              }
              $env.config = {
                show_banner: false
                use_kitty_protocol: true

                edit_mode: vi
                cursor_shape: {
                  vi_insert: line
                  vi_normal: underscore
                }
                history: {
                  max_size: 100_000 # Session has to be reloaded for this to take effect
                  sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
                  file_format: "sqlite" # "sqlite" or "plaintext"
                  isolation: true # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
                }
                  keybindings: [
          {
            name: fzf_file_menu
            modifier: control
            keycode: char_t
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menu name: fzf_file_menu }
          }
          {
            name: fzf_dir_menu
            modifier: control
            keycode: char_g
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menu name: fzf_dir_menu }
          }
        ]

        menus: [
          {
              name: fzf_file_menu
              only_buffer_difference: true
              marker: "# "
              type: {
                  layout: list
                  page_size: 10
              }
              style: {
                  text: "#91d7e3"
                  selected_text: { fg: "#91d7e3" attr: r }
                  description_text: yellow
              }
              source: { |buffer, position|
                  fd --type f --full-path $env.PWD
                  | fzf -f $buffer | lines
                  | each { |v| { value: ($v | str trim) }}
              }
          }
          {
            name: fzf_dir_menu
            only_buffer_difference: true
            marker: "# "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: "#91d7e3"
                selected_text: { fg: "#91d7e3" attr: r }
                description_text: yellow
            }
            source: { |buffer, position|
                fd --type d --full-path $env.PWD
                | fzf -f $buffer | lines
                | each { |v| { value: ($v | str trim) }}
            }
          }
        ]
                # completions: {
                #   case_sensitive: false # set to true to enable case-sensitive completions
                #   quick: true  # set this to false to prevent auto-selecting completions when only one remains
                #   partial: true  # set this to false to prevent partial filling of the prompt
                #   algorithm: "prefix"  # prefix or fuzzy
                #   external: {
                #     enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
                #     max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
                #     completer: $carapace_completer
                #   }
                #   use_ls_colors: true # set this to true to enable file/path/directory completions using LS_COLORS
                # }
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
