{
  description = "Haskell flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (sys:
      let pkgs = nixpkgs.legacyPackages.${sys};
      in {
        packages.dummy = pkgs.haskellPackages.callCabal2nix "dummy" ./. {};
        defaultPackage = self.packages.${sys}.dummy;

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            (haskellPackages.ghcWithPackages (p: [ p.hlint ]))
          ];
        };
      });
}
