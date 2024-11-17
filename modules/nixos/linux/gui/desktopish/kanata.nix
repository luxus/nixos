{
  services.kanata = {
    enable = true;
    keyboards.default.config = ''
      (defcfg
        ;; Process keys not explicitly mapped
        process-unmapped-keys yes
      )

      (defsrc
        ;; Define the keys to be intercepted
        caps 1 2 3 4 5 6 7 8 9 0
      )

      (deflayer base
        ;; Remap Caps Lock to tap Escape and hold to activate the "fn-layer"
        (tap-hold 200 esc (layer-toggle fn-layer))
      )

      (deflayer fn-layer
        ;; Remap numbers to function keys when in this layer
        1 f1
        2 f2
        3 f3
        4 f4
        5 f5
        6 f6
        7 f7
        8 f8
        9 f9
        0 f10
      )
    '';
  };
}
