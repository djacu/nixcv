{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/standardStringOut.nix
    (
      import
      ../components/orderedTaggedContent.nix
      [
        ../templates/newenvironment.nix
        ../titlesec/titleformat.nix
      ]
    )
  ];
  options = {
    type = lib.mkOption {
      type = types.enum ["template"];
      default = "template";
      description = "Type";
      internal = true;
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex =
        lib.concatStringsSep
        "\n\n"
        (cfg.outOrdered "latex");
    };
  };
}
