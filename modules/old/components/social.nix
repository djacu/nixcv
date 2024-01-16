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
    faicons = lib.mkOption {
      description = "A map of icons that can be used to map `network` to a Font Awesome 5 icon.";
      type = types.attrsOf types.str;
      default = let
        faWrap = icon: "\\faIcon{${icon}}";
      in (
        lib.genAttrs
        [
          "discord"
          "facebook"
          "github"
          "gitlab"
          "instagram"
          "linkedin"
          "mastodon"
          "tiktok"
          "twitch"
          "twitter"
          "user"
          "youtube"
        ]
        (name: faWrap name)
      );
    };

    _out.social = {
      plaintext = lib.mkOption {
        description = "This modules output.";
        type = types.str;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };
  };
  config = {
    _out.social = {
      plaintext = cfg.url;
      latex = let
        icon =
          if builtins.isNull cfg.network
          then ""
          else cfg.faicons.${cfg.network} or "";
        text =
          if (! builtins.isNull cfg.url) && (! builtins.isNull cfg.urlShort)
          then "\\href{${cfg.url}}{${cfg.urlShort}}"
          else if (! builtins.isNull cfg.url)
          then cfg.url
          else if (! builtins.isNull cfg.urlShort)
          then cfg.urlShort
          else if (! builtins.isNull cfg.username)
          then cfg.username
          else let
            parents = utils.getSubmoduleParents options;
          in
            throw ''${parents} not defined corrently. One of "username", "url", or "urlShort" must be set.'';
      in "  \\profileItem{${icon}}{${text}}";
    };
  };
}
