{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["references"];
      default = "references";
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
    _outPlaintext = lib.mkOption {
      description = "This modules plaintext output.";
      type = types.str;
      visible = false;
      readOnly = true;
    };
  };
  config = {
    _outPlaintext =
      utils.concatNewlineFiltered
      null
      [
        cfg.name
        cfg.organization
        cfg.phone
        cfg.email
      ];
  };
}
