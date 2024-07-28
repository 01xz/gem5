{
  description = "gem5";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        deps = with pkgs; [
          pkgsCross.riscv64-embedded.buildPackages.gcc
          pkgsCross.riscv64-embedded.buildPackages.gdb
          capstone
          clang
          gnum4
          gperftools
          hdf5-cpp
          libpng
          scons
          zlib
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = deps;
          nativeBuildInputs = with pkgs; [
            clang-tools
          ];
        };
      }
    );
}
