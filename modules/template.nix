{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.PROGRAM;
    #script = pkgs.writeShellScriptBin "script" ''${builtins.readFile ./script}'';


in {
    options.modules.PROGRAM = { enable = mkEnableOption "PROGRAM"; };

    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	];

	home.file.".config/...".source = ./file;
    };
}
