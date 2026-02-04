inputs:
{ pkgs, ... }:
{
  environment.systemPackages = [
    inputs.antigravity.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
