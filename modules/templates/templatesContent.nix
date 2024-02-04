{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;

  modulesLib = import ../../lib/modules.nix {inherit lib;};
in {
  imports = [
    ../components/standardStringOut.nix

    (
      import
      ../components/taggedName.nix
      {
        name = "environments";
        submodules = [
          ../templates/newenvironment.nix
        ];
        ordered = false;
      }
    )

    (
      import
      ../components/taggedName.nix
      {
        name = "titlesec";
        submodules = [
          ../titlesec/titleformat.nix
        ];
        ordered = false;
      }
    )

    (
      import
      ../components/taggedName.nix
      {
        name = "latex";
        submodules = [
          ../templates/rawlatex.nix
        ];
        ordered = false;
      }
    )

    (
      import
      ../components/taggedName.nix
      {
        name = "packages";
        submodules = [
          ../templates/packages.nix
        ];
        ordered = false;
      }
    )

    (
      import
      ../components/taggedName.nix
      {
        name = "enumitem";
        submodules = [
          ../enumitem/enumitem.nix
          #../enumitem/newlist.nix
          #../enumitem/setlist.nix
        ];
        ordered = false;
      }
    )
  ];

  options = {
    type = lib.mkOption {
      type = types.enum ["templatesContent"];
      default = "templatesContent";
      description = "Type";
      internal = true;
    };
  };

  config = {
    _out = {
      plaintext = "";
      latex = (
        lib.concatStringsSep
        "\n"
        (
          []
          ++ (cfg.packagesOutOrdered "latex")
          ++ (cfg.environmentsOutOrdered "latex")
          ++ (cfg.titlesecOutOrdered "latex")
          ++ (cfg.enumitemOutOrdered "latex")
          ++ (cfg.latexOutOrdered "latex")
        )
      );
    };
  };
}
