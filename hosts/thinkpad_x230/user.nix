{ config, lib, inputs, ...}:

{
    imports = [ ../../modules/default.nix ];
    config.modules = {
        # gui
        firefox.enable = true;
        hyprland.enable = true;
        wal.enable = true;
        waybar.enable = true;
        swww.enable = true;
        dunst.enable = true;
        wofi.enable = true;

        # cli
        kitty.enable = true;
        ranger.enable = true;
        starship.enable = true;

        # system
        xdg.enable = true;
        packages.enable = true;
    };
}
