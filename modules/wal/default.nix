{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.wal;

in {
    options.modules.wal = { enable = mkEnableOption "wal"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    (pkgs.python3.withPackages(ps: with ps; [ pywal ]))
	];

        home.file.".config/wal/templates/colors-hyprland.conf".source = ./templates/colors-hyprland.conf;
        home.file.".config/wal/templates/colors-waybar.conf".source = ./templates/colors-waybar.conf;
        home.file.".config/wal/templates/colors-wofi.conf".source = ./templates/colors-wofi.conf;
    };
}
