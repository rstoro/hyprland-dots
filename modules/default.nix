{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "21.03";
    imports = [
        # gui
        ./hyprland
        ./wal
        ./waybar
        ./swww
        ./dunst
        ./wofi

        # cli
        ./kitty
        ./ranger
        ./starship

        # system
        ./xdg
	./packages
    ];
}
