inputs:
{
  config,
  pkgs,
  ...
}:
let
  cfg = config.omarchy;
  packages = import ../packages.nix { inherit pkgs; };
in
{
  imports = [
    (import ./hyprland.nix inputs)
    (import ./system.nix)
    (import ./antigravity.nix inputs)
    (import ./containers.nix)
  ];
}
