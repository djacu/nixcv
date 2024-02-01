{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  contentName = "enumitem";
in {
  imports = [
    (
      import
      ../components/taggedName.nix
      {
        name = contentName;
        submodules = [
          ./newlist.nix
          ./setlist.nix
        ];
        ordered = false;
      }
    )
  ];

  options = {
    type = lib.mkOption {
      type = lib.types.enum ["enumitem"];
      default = "enumitem";
      description = "Type";
      internal = true;
    };

    _out = {
      latex = lib.mkOption {
        description = "This modules enumitem output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };

  config = {
    _out = {
      latex =
        lib.concatStringsSep
        "\n"
        (cfg."${contentName}OutOrdered" "latex");
    };
  };
}
