{
  description = "elixir dummy";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (sys:
      let
        pkgs = nixpkgs.legacyPackages.${sys};
        beamPkgs = pkgs.beam.packagesWith pkgs.beam.interpreters.erlang;
      in {
        packages.dummy = beamPkgs.mixRelease {
          pname = "dummy";
          version = "0.1.0";
          src = ./.;
          mixEnv = "prod";
          buildInputs = [ beamPkgs.elixir_1_13 ];
        };

        defaultPackage = self.packages.${sys}.dummy;

        devShell = pkgs.mkShell {
          shellHook = ''
              # this allows mix to work on the local directory
              export MIX_HOME=$PWD/.nix-mix
              export HEX_HOME=$PWD/.nix-mix
              export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH
              # TODO: not sure how to make hex available without installing it afterwards.
              mix local.hex --if-missing
              export LANG=en_US.UTF-8
              export ERL_AFLAGS="-kernel shell_history enabled"
              '';
        };
      });
}
