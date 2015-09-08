with import <nixpkgs> {}; {
  clungEnv = stdenv.mkDerivation {
    name = "clung";
    version = "0.1";
    src = ./.;
    buildInputs = [ stdenv racket llvmPackages.clang gdb ];
    LD_LIBRARY_PATH = "${llvmPackages.clang}/lib";
  };
}
