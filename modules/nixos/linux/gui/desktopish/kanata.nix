{ pkgs, ... }:
{
  services.kanata = {
    enable = true;
    package = pkgs.kanata-with-cmd;
    keyboards.default.extraDefCfg = "process-unmapped-keys yes";
    keyboards.default.config = ''
      (defsrc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )

      (defalias
        ;; tap for caps lock, hold for left control
        cap (tap-hold 200 200 esc lctl)
      )
      (defalias
        f (tap-hold 200 200 f (layer-while-held arrows))
      )

      (defalias
        rightalt (tap-hold 200 200 ralt (layer-while-held rightalt))
      )
      (deflayer qwerty
        grv 1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @cap a    s    d    @f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            @rightalt rmet rctl
      )
      (defalias
        oum (fork
         (unicode ö)
         (unicode Ö) (lsft rsft)))
      (defalias
        uum (fork
         (unicode ü)
         (unicode Ü) (lsft rsft)))
      (defalias
        aum (fork
         (unicode ä)
         (unicode Ä) (lsft rsft)))
      (defalias ss (unicode ß))
        
      (deflayer rightalt
        _    _    _    _    _    _    _   _     _   _     _    _    _   _
        _    _    _    _    _    _    _   @uum  _   @oum  _    _    _   _
        _    @aum @ss  _    _    _    _   _     _   _     _    _    _
        _    _    _    _    _    _    _   _     _   _     _    _
        _    _    _              _              _   _     _
      )
      (deflayer arrows
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    left  up    down  right    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _              _              _    _    _
      )
    '';
  };
}