{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.ranger;

in {
    options.modules.ranger = { enable = mkEnableOption "ranger"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    ranger
	];

        home.file.".config/ranger/rc.conf".source = ./rc.conf;
    };
}
