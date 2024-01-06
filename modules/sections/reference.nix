{
  lib,
  config,
  options,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["reference"];
      default = "reference";
      internal = true;
      description = "Type";
    };
    name = lib.mkOption {
      description = "The reference's name.";
      type = types.nullOr types.str;
      default = null;
      example = "John Doe";
    };
    organization = lib.mkOption {
      description = "The reference's organization.";
      type = types.nullOr types.str;
      default = null;
      example = "The NixOS Foundation";
    };
    phone = lib.mkOption {
      description = "The reference's phone number.";
      type = types.nullOr types.str;
      default = null;
      example = "123.456.7890";
    };
    email = lib.mkOption {
      description = "The reference's email.";
      type = types.nullOr types.str;
      default = null;
      example = "jdoe@nixos.org";
    };

    _latexDedicatedFields = lib.mkOption {
      description = "Options with dedicated LaTeX commands.";
      type = types.listOf types.str;
      default = [
        "name"
        "organization"
      ];
      visible = false;
      internal = true;
    };
    _latexIgnoredFields = lib.mkOption {
      description = "Options that are internal and not needed for LaTeX.";
      type = types.listOf types.str;
      default =
        [
          "_module"
        ]
        ++ (
          lib.attrNames (
            lib.filterAttrs
            (name: value: ! (value.visible or true) || (value.internal or false))
            options
          )
        );
      visible = false;
      internal = true;
    };

    _out.reference = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = let
    miscFields =
      builtins.removeAttrs
      cfg
      (cfg._latexIgnoredFields ++ cfg._latexDedicatedFields);
  in {
    _out.reference = {
      plaintext =
        utils.concatNewlineFiltered
        null
        [
          cfg.name
          cfg.organization
          cfg.phone
          cfg.email
        ];
      latex =
        utils.concatStringsSepFiltered
        "\n"
        ""
        (
          lib.flatten
          [
            "\\begin{references}"
            (lib.optionalString (! builtins.isNull cfg.name) "\\referenceName{${cfg.name}}")
            "\\begin{references}"
            (lib.optionalString (! builtins.isNull cfg.name) "\\referenceOrg{${cfg.organization}}")
            (
              builtins.map
              (x: (lib.optionalString (! builtins.isNull cfg.${x}) "\\referenceContact{${cfg.${x}}}"))
              (builtins.attrNames miscFields)
            )
            "\\end{references}"
            "\\end{references}"
          ]
        );
    };
  };
}
