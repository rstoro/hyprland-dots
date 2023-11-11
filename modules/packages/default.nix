{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;
in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    hyprland
	    waybar
	    swww
	    dunst
	    wofi
	    kitty
	    ranger
	    starship
	    grim
	    slurp
	    clipman
	    procps
	    wf-recorder
 	    firefox
	    ffmpeg
	    procps
	    pfetch
	    vim
	    pavucontrol
	    maintenance
	    (pkgs.python3.withPackages(ps: with ps; [ pywal ]))
	];
    };
}
