{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.github-nix-ci.nixosModules.default
  ];

  services.github-nix-ci = {
    age.secretsDir = self + /secrets;
    personalRunners = {
      "luxus/luxus".num = 1;
    };
  };
}
