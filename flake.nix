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
  haskellPackages = pkgs.haskell.packages.ghc928;
  struo = haskellPackages.callPackage ./struo.nix {};
in {
  packages.x86_64-linux.default = struo;

  devShells.x86_64-linux.default = haskellPackages.shellFor {
    packages = _: [ struo ];
    nativeBuildInputs = with haskellPackages; [
      ghcid
      hlint
      cabal2nix
      cabal-install
    ];
  };
};

}
