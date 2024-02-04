{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  contentName = "bibresources";
in {
  imports = [
    ../components/bibresourceStringOut.nix
    (
      import
      ../components/taggedName.nix
      {
        name = contentName;
        submodules = [
          ./online.nix
        ];
        ordered = false;
      }
    )
  ];
  config = {
    _out = {
      bibliography =
        lib.concatStringsSep
        "\n\n"
        (cfg."${contentName}OutOrdered" "bibliography");
    };
  };
}
