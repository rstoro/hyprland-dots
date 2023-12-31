{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.starship;

in {
    options.modules.starship = { enable = mkEnableOption "starship"; };
    config = mkIf cfg.enable {
        home.file.".config/starship/starship.toml".source = ./starship.toml;
    };
}
