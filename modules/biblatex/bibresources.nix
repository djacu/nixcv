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
      ../components/orderedTaggedName.nix
      contentName
      [
        ./online.nix
      ]
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
