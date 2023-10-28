# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # timezone
  time.timeZone = "EST5EDT";

  # locale
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 windowing system with keymap
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # touchpad support
  services.xserver.libinput.enable = true;

  # printing (CUPS)
  services.printing.enable = true;

  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  # useraccount
  users.users.rs = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      firefox
      tree
    ];
  };

  # fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # packages
  environment.systemPackages = with pkgs; [
    kitty
    vim
    wget
    git
    pfetch
    (pkgs.python3.withPackages(ps: with ps; [ pywal ]))
    wofi
    swww
    waybar
    dunst
    ranger
    starship
    clipman
    grim
    slurp
  ];

  # hyprland
  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true;
    xwayland.enable = true;
  };

  # session variables
  environment.sessionVariables = {
    # if cursor is not visible
    WLR_NO_HARDWARE_CURSORS = "1";

    # hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  # enable opengl
  hardware = {
    opengl.enable = true;
    # nvidia.modesetting.enable = true;
  };

  # xdg portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # firewall TODO: setup
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;

  # enable nix-command
  nix.settings.experimental-features = [ "nix-command" ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

