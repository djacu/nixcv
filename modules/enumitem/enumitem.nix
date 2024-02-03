{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    (
      import
      ../components/taggedName.nix
      {
        name = "newlist";
        submodules = [
          ./newlist.nix
        ];
        ordered = false;
      }
    )
    (
      import
      ../components/taggedName.nix
      {
        name = "setlist";
        submodules = [
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
        (builtins.trace cfg)
        lib.concatStringsSep
        "\n"
        (
          []
          ++ (cfg.newlistOutOrdered "latex")
          ++ (cfg.setlistOutOrdered "latex")
        );
    };
  };
}
