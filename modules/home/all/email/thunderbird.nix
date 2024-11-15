{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = true;

    # Thunderbird package is unavailable for Darwin.
    # Install the app manually.
    package = pkgs.hello;

    profiles."default" = {
      isDefault = true;
    };
  };

  accounts.email.accounts = {
    "kai@luxus.ai".thunderbird = {
      enable = true;
    };
    "luxuspur@gmail.com".thunderbird = {
      enable = true;
    };
  };
}
