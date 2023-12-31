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
  haskellPackages = pkgs.haskell.packages.ghc92;
  struo = haskellPackages.callPackage ./struo.nix {};
in {
  packages.x86_64-linux.default = struo.overrideAttrs (old: {
    nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.installShellFiles ];
    postInstall = ''
      installShellCompletion --cmd struo \
        --bash <($out/bin/struo --bash-completion-script $out/bin/struo) \
        --fish <($out/bin/struo --fish-completion-script $out/bin/struo) \
        --zsh <($out/bin/struo --zsh-completion-script $out/bin/struo)
    '';
  });

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
