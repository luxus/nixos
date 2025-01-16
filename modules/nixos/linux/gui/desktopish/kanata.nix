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
      (defvar
        tap-time 150
        hold-time 200
      )
      (defalias
        caps (tap-hold 100 100 esc lctl)
        a (tap-hold $tap-time $hold-time a lmet)
        s (tap-hold $tap-time $hold-time s lalt)
        d (tap-hold $tap-time $hold-time d lsft)
        f (tap-hold $tap-time $hold-time f lctl)
        j (tap-hold $tap-time $hold-time j rctl)
        k (tap-hold $tap-time $hold-time k rsft)
        l (tap-hold $tap-time $hold-time l ralt)
        ; (tap-hold $tap-time $hold-time ; rmet)
      )

      (defalias
        rightalt (tap-hold 200 200 ralt (layer-while-held rightalt))
      )
      (deflayer qwerty
        grv 1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @caps @a    @s    @d    @f    g    h    @j    @k    @l    @;    '    ret
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
        _    @aum @ss  _    _    _    AG-h   AG-j     AG-k   AG-l     _    _    _
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
