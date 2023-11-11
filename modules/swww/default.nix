{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.swww;

in {
    options.modules.swww = { enable = mkEnableOption "swww"; };
    config = mkIf cfg.enable {
	home.file.".config/swww/generate.sh".source = ./generate.sh;
    };
}
