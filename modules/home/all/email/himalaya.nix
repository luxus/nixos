{
  home.shellAliases = {
    H = "himalaya";
    Hr = "himalaya message read";
    Hd = "himalaya message delete";
    Hs = "himalaya account sync";
  };

  programs.himalaya = {
    enable = true;
  };

  accounts.email.accounts = {
    "kai@luxus.ai" = {
      himalaya = {
        enable = true;
        # Don't forget to run `himalaya account sync` first!
        settings.sync = {
          enable = true;
        };
      };
    };
  };
}
