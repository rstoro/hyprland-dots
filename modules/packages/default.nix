{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    grim
	    slurp
	    clipman
	    procps
	    wl-recorder
 	    firefox
	    ffmpeg
	    procps
	    maintenance
	];

        home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    };
}
