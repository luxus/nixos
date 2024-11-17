{ pkgs, ... }:
{
  services.kanata = {
    enable = false;
    package = pkgs.kanata-with-cmd;
    keyboards.default.extraDefCfg = "process-unmapped-keys yes";
    keyboards.default.config = ''
      (defsrc
        ;; Define the keys to be intercepted
        caps
      )

      (defalias
        ;; tap for caps lock, hold for left control
        cap (tap-hold 200 200 esc lctl)
      )
      (deflayer example
        @cap
      )
    '';
  };
}
