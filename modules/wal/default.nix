{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.wal;

in {
    options.modules.wal = { enable = mkEnableOption "wal"; };
    config = mkIf cfg.enable {
        home.file.".config/wal/templates/colors-hyprland.conf".source = ./templates/colors-hyprland.conf;
        home.file.".config/wal/templates/colors-waybar.css".source = ./templates/colors-waybar.css;
        home.file.".config/wal/templates/colors-wofi.css".source = ./templates/colors-wofi.css;
    };
}
