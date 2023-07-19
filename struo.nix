{ mkDerivation, base, lib }:
mkDerivation {
  pname = "struo";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base ];
  license = lib.licenses.agpl3Plus;
  mainProgram = "struo";
}
