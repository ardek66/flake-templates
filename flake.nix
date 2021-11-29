{
  description = "bunch of templates because im lazy";

  outputs = { self }: {
    templates = {
      ocaml = {
        path = ./ocaml;
        description = "OCaml flake (i hate dune)";
      };
    };
  };
}
