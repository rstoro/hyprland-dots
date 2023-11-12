{ config, pkgs, inputs, ... }:

{
    # laptop packages + required
    environment.systemPackages = with pkgs; [
        acpi tlp git
    ];

    fonts = {
        packages = with pkgs; [
            #openmoji-color
            (nerdfonts.override { fonts = [ "Hack" ]; })
        ];

        fontconfig = {
            hinting.autohint = true;
            #defaultFonts = {
            #  emoji = [ "OpenMoji Color" ];
            #};
        };
    };


    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-gtk
            ];
        };
    };

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

    boot = {
        tmp.cleanOnBoot = true;
        loader = {
	    systemd-boot.enable = true;
	    systemd-boot.editor = false;
	    efi.canTouchEfiVariables = true;
	    timeout = 5;
        };
    };

    time.timeZone = "EST5EDT";
    i18n.defaultLocale = "en_US.UTF-8";
    #console = {
        #font = "Lat2-Terminus16";
        #keyMap = "us";
    #};

    users.users.rs = {
        isNormalUser = true;
        extraGroups = [ "input" "wheel" "networkmanager" ];
    };

    networking = {
        networkmanager.enable = true;
        firewall = {
            enable = true;
            allowedTCPPorts = [ 443 80 ];
            allowedUDPPorts = [ 443 80 44857 ];
            allowPing = false;
        };
    };

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
	WLR_NO_HARDWARE_CURSORS = "1";
    };

    security = {
        sudo.enable = true;
        #doas = {
        #    enable = true;
        #    extraRules = [{
        #        users = [ "rs" ];
        #        keepEnv = true;
        #        persist = true;
        #    }];
        #};

    	rtkit.enable = true;
        protectKernelImage = true;
    };

    sound = {
        enable = true;
    };

    hardware = {
	pulseaudio.enable = true;
    };

    services.xserver = {
	enable = true;
	layout = "us";
	xkbOptions = "eurosign:e,caps:escape";
	#displayManager.startx.enable = true;
	libinput.enable = true;
	#printing.enable = true;
    };

    services.pipewire = {
        enable = false;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };
    
    hardware = {
        bluetooth.enable = false;
        opengl = {
            enable = true;
            driSupport = true;
	    #nvidia.modesetting.enable = true;
        };
    };

    programs.hyprland = {
	enable = true;
	xwayland.enable = true;
    };

    # Do not touch
    system.stateVersion = "20.09";
}
