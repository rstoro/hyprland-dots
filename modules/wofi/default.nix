{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.wofi;

in {
    options.modules.wofi = { enable = mkEnableOption "wofi"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    wofi
	];

        home.file.".config/wofi/style.css".source = ./style.css;
        home.file.".config/wofi/config".source = ./config;
    };
}
