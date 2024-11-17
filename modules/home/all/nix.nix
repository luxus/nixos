{
  # Garbage collect automatically every week
  nix.gc.automatic = true;
  home.enableNixpkgsReleaseCheck = false;

  # Nix configuration is managed globally by nix-darwin.
  # Prevent $HOME nix.conf from disrespecting it.
  home.file."~/.config/nix/nix.conf".text = "";
}
