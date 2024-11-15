let
  iCloudMailSettings = {
    imap = {
      host = "imap.mail.me.com";
      port = 993;
    };
    smtp = {
      host = "smtp.mail.me.com";
      port = 587;
      tls.useStartTls = true;
    };
  };
  GmailSettings = {
    imap = {
      host = "imap.gmail.com";
      port = 993;
    };
    smtp = {
      host = "smtp.gmail.com";
      port = 465;
      # tls.useStartTls = true;
    };
  };
in
{
  imports = [
    ./himalaya.nix
    ./thunderbird.nix
  ];
  accounts.email.accounts = {
    "kai@luxus.ai" = iCloudMailSettings // {
      primary = true;
      realName = "Kai Löhnert";
      address = "kai@luxus.ai";
      aliases = [ "kl82@me.com" ];
      userName = "kai@luxus.ai";
      passwordCommand = "op read op://Private/iCloud/home-manager";
    };
    "luxuspur@gmail.com" = GmailSettings // {
      realName = "Kai Löhnert";
      address = "luxuspur@gmail.com";
      userName = "luxuspur@gmail.com";
      passwordCommand = "op read op://Private/Google-luxuspur/home-manager";
    };
  };
}
