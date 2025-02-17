{
  description = "Srid's NixOS / nix-darwin configuration";

  inputs = {
    # Principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    zig_overlay.url = "github:mitchellh/zig-overlay";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-unified.url = "github:srid/nixos-unified";
    disko.url = "github:nix-community/disko";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    nix-comfyui.url = "github:luxus/nix-comfyui";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.url = "github:yaxitech/ragenix";
    nuenv.url = "github:hallettj/nuenv/writeShellApplication";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Software inputs
    github-nix-ci.url = "github:juspay/github-nix-ci";
    nixos-vscode-server.flake = false;
    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    actualism-app.url = "github:srid/actualism-app";
    omnix.url = "github:juspay/omnix";
    hyprland.url = "github:hyprwm/Hyprland";

    # Devshell
    treefmt-nix.url = "github:numtide/treefmt-nix";

    ghostty.url = "github:clo4/ghostty-hm-module";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      imports = (
        with builtins; map (fn: ./modules/flake-parts/${fn}) (attrNames (readDir ./modules/flake-parts))
      );

      perSystem =
        { lib, system, ... }:
        {
          # Make our overlay available to the devShell
          # "Flake parts does not yet come with an endorsed module that initializes the pkgs argument.""
          # So we must do this manually; https://flake.parts/overlays#consuming-an-overlay
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = lib.attrValues self.overlays;
            config.allowUnfree = true;
          };
        };
    };
}
