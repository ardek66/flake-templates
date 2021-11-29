{
  description = "nim flake";

  inputs = {
    flake-nimble.url = "github:nix-community/flake-nimble";
  };
  
  outputs = { self, nixpkgs, flake-nimble }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      nimblePkgs = flake-nimble.packages.x86_64-linux;
    in {
      packages.x86_64-linux.dummy = pkgs.nimPackages.buildNimPackage {
        pname = "dummy";
        version = "0.1.0";
        src = ./.;
        buildInputs = [ ];
      };

      defaultPackage.x86_64-linux = self.packages.x86_64-linux.dummy;
    };
}
