{ flake, ... }:
let
  my-comfyui = flake.inputs.pkgs.comfyuiPackages.comfyui.override {
    extensions = [
      flake.inputs.pkgs.comfyuiPackages.extensions.acly-inpaint
      flake.inputs.pkgs.comfyuiPackages.extensions.acly-tooling
      flake.inputs.pkgs.comfyuiPackages.extensions.cubiq-ipadapter-plus
      flake.inputs.pkgs.comfyuiPackages.extensions.fannovel16-controlnet-aux
    ];

    commandLineArgs = [
      "--preview-method"
      "auto"
    ];
  };
in
{ }
