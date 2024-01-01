{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  options = {
    network = lib.mkOption {
      description = "The social media platform name.";
      default = null;
      type = types.nullOr types.str;
    };
    username = lib.mkOption {
      description = "Your username on the platform.";
      default = null;
      type = types.nullOr types.str;
    };
    url = lib.mkOption {
      description = "A link to your profile.";
      default = null;
      type = types.nullOr types.str;
    };
    urlShort = lib.mkOption {
      description = "A short version of `url`.";
      default = null;
      type = types.nullOr types.str;
    };
    _outPlaintext = lib.mkOption {
      description = "This modules output.";
      type = types.str;
      readOnly = true;
    };
  };
  config = {
    _outPlaintext = cfg.url;
  };
}
