{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.waybar;

in {
    options.modules.waybar = { enable = mkEnableOption "waybar"; };
    config = mkIf cfg.enable {
        home.file.".config/waybar/config".source = ./config;
        home.file.".config/waybar/style.css".source = ./style.css;
    };
}
