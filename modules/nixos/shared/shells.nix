{ pkgs, ... }:
{
  environment.shells = with pkgs; [
    zsh
    nushell
    bash
  ];
}
