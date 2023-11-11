{ config, pkgs, inputs, ... }:

{
    # Remove unecessary preinstalled packages
    environment.defaultPackages = [ ];
    services.xserver.desktopManager.xterm.enable = false;

    environment.systemPackages = with pkgs; [
        acpi tlp git
    ];

    # Install fonts
    fonts = {
        fonts = with pkgs; [
            #roboto
            openmoji-color
            (nerdfonts.override { fonts = [ "Hack" ]; })
        ];

        fontconfig = {
            hinting.autohint = true;
            defaultFonts = {
              emoji = [ "OpenMoji Color" ];
            };
        };
    };


    # Wayland stuff: enable XDG integration, allow sway to use brillo
    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk
            ];
            gtkUsePortal = true;
        };
    };

    # Nix settings, auto cleanup and enable flakes
    nix = {
        settings.auto-optimise-store = true;
        settings.allowed-users = [ "rs" ];
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs = true
            keep-derivations = true
        '';
    };

    # Boot settings: clean /tmp/, latest kernel and enable bootloader
    boot = {
        cleanTmpDir = true;
        loader = {
        systemd-boot.enable = true;
        systemd-boot.editor = false;
        efi.canTouchEfiVariables = true;
        timeout = 0;
        };
    };

    # Set up locales (timezone and keyboard layout)
    time.timeZone = "EST5EDT";
    i18n.defaultLocale = "en_US.UTF-8";
    #console = {
        #font = "Lat2-Terminus16";
        #keyMap = "us";
    #};

    # Set up user and enable sudo
    users.users.rs = {
        isNormalUser = true;
        extraGroups = [ "input" "wheel" ];
    };

    # Set up networking and secure it
    networking = {
        networkmanager.enable = true;
        firewall = {
            enable = true;
            allowedTCPPorts = [ 443 80 ];
            allowedUDPPorts = [ 443 80 44857 ];
            allowPing = false;
        };
    };

    # Set environment variables
    environment.variables = {
        NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
        NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
        GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
        GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
        MOZ_ENABLE_WAYLAND = "1";
        EDITOR = "vim";
        DIRENV_LOG_FORMAT = "";
        DISABLE_QT5_COMPAT = "0";
	NIXOS_OZONE_WL = "1";
    };

    # Security 
    security = {
        sudo.enable = false;
        doas = {
            enable = true;
            extraRules = [{
                users = [ "rs" ];
                keepEnv = true;
                persist = true;
            }];
        };

        # Extra security
        protectKernelImage = true;
    };

    # Sound
    sound = {
        enable = true;
    };

    hardware = {
	pulseaudio.enable = true;
    };

    security.rtkit.enable = true;

    services.pipewire = {
        enable = false;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };
    
    # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
    hardware = {
        bluetooth.enable = false;
        opengl = {
            enable = true;
            driSupport = true;
        };
    };

    # Do not touch
    system.stateVersion = "20.09";
}
