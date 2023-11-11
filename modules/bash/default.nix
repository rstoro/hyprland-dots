{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.bash;

in {
    options.modules.bash = { enable = mkEnableOption "bash"; };
    config = mkIf cfg.enable {
        home.file.".bashrc".source = ./bashrc;
    };
}
