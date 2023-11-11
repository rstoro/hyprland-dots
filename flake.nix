{
    description = "NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nur = {
            url = "github:nix-community/NUR";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { home-manager, nixpkgs, nur, ... }@inputs: 
        let
            system = "x86_64-linux";

            pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

            lib = nixpkgs.lib;

            mkSystem = pkgs: system: hostname:
                pkgs.lib.nixosSystem {
                    system = system;
                    modules = [
                        { networking.hostName = hostname; }
                        ./modules/system/configuration.nix
                        (./. + "/hosts/${hostname}/hardware-configuration.nix")
                        home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useUserPackages = true;
                                useGlobalPkgs = true;
                                extraSpecialArgs = { inherit inputs; };
                                users.rs = (./. + "/hosts/${hostname}/user.nix");
                            };
                            nixpkgs.overlays = [
                                nur.overlay
                            ];
                        }
                    ];
                    specialArgs = { inherit inputs; };
                };

        in {
            nixosConfigurations = {
                thinkpad_x230 = mkSystem inputs.nixpkgs "x86_64-linux" "thinkpad_x230";
                msi = mkSystem inputs.nixpkgs "x86_64-linux" "msi";
            };
    };
}
