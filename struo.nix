{ mkDerivation, base, lib, optparse-applicative, process }:
mkDerivation {
  pname = "struo";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base optparse-applicative process ];
  license = lib.licenses.agpl3Plus;
  mainProgram = "struo";
}
