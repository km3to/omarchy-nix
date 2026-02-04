inputs:
{ pkgs, ... }:
{
  environment.systemPackages = [
    inputs.antigravity.packages.${pkgs.system}.default
  ];
}
