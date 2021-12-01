{
  description = "Haskell flake";

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.dummy = pkgs.haskellPackages.callCabal2nix "dummy" ./. {};
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.dummy;

      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [
          (haskellPackages.ghcWithPackages (p: [ p.haskell-language-server ]))
        ];
      };
    };
}
