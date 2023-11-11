{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.wal;

in {
    options.modules.wal = { enable = mkEnableOption "wal"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    (pkgs.python3.withPackages(ps: with ps; [ pywal ]))
	];

        home.file.".config/wal/colorschemes".source = ./colorschemes;
        home.file.".config/wal/templates".source = ./templates;
    };
}
