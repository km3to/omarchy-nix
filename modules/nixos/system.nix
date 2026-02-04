{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.omarchy;
  packages = import ../packages.nix {
    inherit pkgs lib;
    exclude_packages = cfg.exclude_packages;
  };
in
{
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Configure keymap in X11 and Console
  services.xserver.xkb = {
    layout = "us,bg";             # Adds US English and Bulgarian
    variant = ",phonetic";        # Second layout uses phonetic (first is default)
    options = "grp:alt_shift_toggle"; # Switch between them with Alt + Shift
  };

  # This ensures your console (TTY) also respects these settings
  console.useXkbConfig = true;

  # Initial login experience
  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
  };

  # Install packages
  environment.systemPackages = packages.systemPackages;
  programs.direnv.enable = true;

  # Networking
  services.resolved.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  networking = {
    networkmanager.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.caskaydia-mono
  ];
}
