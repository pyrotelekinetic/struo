{

description = "A utility for switching and testing nixos configurations";

inputs.nixpkgs = {
  type = "github";
  owner = "NixOS";
  repo = "nixpkgs";
  ref = "nixos-23.05";
};

outputs = { self, nixpkgs }: let
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
  callPackage = pkgs.haskell.packages.ghc928.callPackage;
in {
  packages.x86_64-linux.default = callPackage ./struo.nix {};
};

}
