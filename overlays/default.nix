{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
self: super: {
  nuenv = (inputs.nuenv.overlays.nuenv self super).nuenv;
  fuckport = self.callPackage "${packages}/fuckport.nix" { };
  # llama-cpp = self.callPackage "${packages}/llama-cpp.nix" { };
  twitter-convert = self.callPackage "${packages}/twitter-convert" { };
  sshuttle-via = self.callPackage "${packages}/sshuttle-via.nix" { };
  monolisa = self.callPackage "${packages}/monolisa.nix" { };
  #FIX: notworking
  # mycomfyui = self.callPackage "${packages}/mycomfyui.nix" { };

  ci = self.callPackage "${packages}/ci" { };
  touchpr = self.callPackage "${packages}/touchpr" { };
  actualism-app = inputs.actualism-app.packages.${self.system}.default;
  omnix = inputs.omnix.packages.${self.system}.default;
  neovim-nightly = flake.inputs.neovim-nightly-overlay.packages.${self.system}.default;
  git-merge-and-delete = self.callPackage "${packages}/git-merge-and-delete.nix" { };
  git-squash = self.callPackage "${packages}/git-squash.nix" { };
}
