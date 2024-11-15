{
  imports = [
    ./basics.nix
  ];

  services = {
    fail2ban = {
      enable = true;
      # ignoreIP = [
        # FIX: don't think i need this
        # "100.80.93.92" # Tailscale "appreciate"
      # ];
    };
  };
}
