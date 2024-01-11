{
  description = "Hoan's macOS setup";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {
    darwinConfigurations = {
      "hoan-mac-vm" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./home/personal.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      # "SDL-C715CYXQ92" = darwin.lib.darwinSystem {
      #   system = "aarch64-darwin";
      #   modules = [
      #     ./configuration.nix
      #     home-manager.darwinModules.home-manager
      #     ./home/work.nix
      #   ];
      #   inputs = { inherit nixpkgs darwin home-manager; };
      # };
    };
  };
}
