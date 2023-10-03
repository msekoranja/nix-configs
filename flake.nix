{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nh = {
    #  url = "github:viperml/nh";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    
    #hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      templates = import ./templates;

      overlays = import ./overlays { inherit inputs outputs; };
      hydraJobs = import ./hydra.nix { inherit inputs outputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
      #  # Main desktop
      #  atlas =  lib.nixosSystem {
      #    modules = [ ./hosts/atlas ];
      #    specialArgs = { inherit inputs outputs; };
      #  };
        # Raspberry PI 4
        rpi4 = lib.nixosSystem {
          modules = [ ./hosts/rpi4 ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "msekoranja@m1air" = lib.homeManagerConfiguration {
          modules = [ ./home/msekoranja/m1air.nix ];
          pkgs = pkgsFor.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "msekoranja@cslwsl" = lib.homeManagerConfiguration {
          modules = [ ./home/msekoranja/cslwsl.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "msekoranja@rpi4" = lib.homeManagerConfiguration {
          modules = [ ./home/msekoranja/rpi4.nix ];
          pkgs = pkgsFor.aarch64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };

    };
}
