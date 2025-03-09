{ pkgs, lib, ... }:

{
  home.sessionPath = lib.mkIf pkgs.stdenv.isDarwin [
    "/usr/local/bin"
    "/etc/profiles/per-user/$USER/bin"
    "/nix/var/nix/profiles/system/sw/bin"
    "/Users/$USER/.local/bin"
    "/Users/$USER/.bun/bin"
  ];
  programs.zsh = {
    enable = true;
    # autosuggestion.enable = true;
    # syntaxHighlighting.enable = true;
    # plugins = [
    #   {
    #     name = "vi-mode";
    #     src = pkgs.zsh-vi-mode;
    #     file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    #   }
    # ];

    envExtra =
      # bash
      ''
        # Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.
        #
        # Do not modify this file unless you know exactly what you are doing.
        # It is strongly recommended to keep all shell customization and configuration
        # (including exported environment variables such as PATH) in ~/.zshrc or in
        # files sourced from ~/.zshrc. If you are certain that you must export some
        # environment variables in ~/.zshenv, do it where indicated by comments below.

        if [ -n "''${ZSH_VERSION-}" ]; then
          # If you are certain that you must export some environment variables
          # in ~/.zshenv (see comments at the top!), do it here:
          #
          #   export GOPATH=$HOME/go
          #
          # Do not change anything else in this file.

          : ''${ZDOTDIR:=~}
          setopt no_global_rcs
          [[ -o no_interactive && -z "''${Z4H_BOOTSTRAPPING-}" ]] && return
          setopt no_rcs
          unset Z4H_BOOTSTRAPPING
        fi

        Z4H_URL="https://raw.githubusercontent.com/romkatv/zsh4humans/v5"
        : "''${Z4H:=''${XDG_CACHE_HOME:-$HOME/.cache}/zsh4humans/v5}"

        umask o-w

        if [ ! -e "$Z4H"/z4h.zsh ]; then
          mkdir -p -- "$Z4H" || return
          >&2 printf '\033[33mz4h\033[0m: fetching \033[4mz4h.zsh\033[0m\n'
          if command -v curl >/dev/null 2>&1; then
            curl -fsSL -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$ || return
          elif command -v wget >/dev/null 2>&1; then
            wget -O-   -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$ || return
          else
            >&2 printf '\033[33mz4h\033[0m: please install \033[32mcurl\033[0m or \033[32mwget\033[0m\n'
            return 1
          fi
          mv -- "$Z4H"/z4h.zsh.$$ "$Z4H"/z4h.zsh || return
        fi

        . "$Z4H"/z4h.zsh || return

        setopt rcs
      '';
    # envExtra = lib.mkIf pkgs.stdenv.isDarwin ''
    #   # Because, adding it in .ssh/config is not enough.
    #   # cf. https://developer.1password.com/docs/ssh/get-started#step-4-configure-your-ssh-or-git-client
    #   export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    # '';
    initExtraBeforeCompInit =
      # bash
      ''
        # Personal Zsh configuration file. It is strongly recommended to keep all
        # shell customization and configuration (including exported environment
        # variables such as PATH) in this file or in files sourced from it.
        #
        # Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

        # Periodic auto-update on Zsh startup: 'ask' or 'no'.
        # You can manually run `z4h update` to update everything.
        zstyle ':z4h:' auto-update      'no'
        # Ask whether to auto-update this often; has no effect if auto-update is 'no'.
        zstyle ':z4h:' auto-update-days '28'

        # Keyboard type: 'mac' or 'pc'.
        zstyle ':z4h:bindkey' keyboard  'mac'

        # Don't start tmux.
        zstyle ':z4h:' start-tmux       no

        # Mark up shell's output with semantic information.
        zstyle ':z4h:' term-shell-integration 'yes'

        # Right-arrow key accepts one character ('partial-accept') from
        # command autosuggestions or the whole thing ('accept')?
        zstyle ':z4h:autosuggestions' forward-char 'accept'

        # Recursively traverse directories when TAB-completing files.
        zstyle ':z4h:fzf-complete' recurse-dirs 'yes'

        # Enable direnv to automatically source .envrc files.
        zstyle ':z4h:direnv'         enable 'yes'
        # Show "loading" and "unloading" notifications from direnv.
        zstyle ':z4h:direnv:success' notify 'yes'

        # Enable ('yes') or disable ('no') automatic teleportation of z4h over
        # SSH when connecting to these hosts.
        zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
        zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
        # The default value if none of the overrides above match the hostname.
        zstyle ':z4h:ssh:*'                   enable 'no'

        # Send these files over to the remote host when connecting over SSH to the
        # enabled hosts.
        zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

        # Clone additional Git repositories from GitHub.
        #
        # This doesn't do anything apart from cloning the repository and keeping it
        # up-to-date. Cloned files can be used after `z4h init`. This is just an
        # example. If you don't plan to use Oh My Zsh, delete this line.
        z4h install ohmyzsh/ohmyzsh || return

        # Install or update core components (fzf, zsh-autosuggestions, etc.) and
        # initialize Zsh. After this point console I/O is unavailable until Zsh
        # is fully initialized. Everything that requires user interaction or can
        # perform network I/O must be done above. Everything else is best done below.
        z4h init || return

        # Extend PATH.
        path=(~/bin $path)

        # Export environment variables.
        export GPG_TTY=$TTY

        # Source additional local files if they exist.
        z4h source ~/.env.zsh


        # Define key bindings.
        z4h bindkey undo Ctrl+/   Shift+Tab  # undo the last command line change
        z4h bindkey redo Option+/            # redo the last undone command line change

        z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
        z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
        z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
        z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

        # Autoload functions.
        autoload -Uz zmv

        # Define functions and completions.
        function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
        compdef _directories md

        # Define named directories: ~w <=> Windows home directory on WSL.
        [[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

        # Define aliases.
        alias tree='tree -a -I .git'

        # Add flags to existing aliases.
        alias ls="''${aliases[ls]:-ls} -A"

        # Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
        setopt glob_dots     # no special treatment for file names with a leading dot
        setopt no_auto_menu  # require an extra TAB press to open the completion menu
      '';
  };
}
