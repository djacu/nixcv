{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ./format.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["profileItem"];
      default = "profileItem";
      description = "Type";
      internal = true;
    };
    content = lib.mkOption {
      description = "A profile item.";
      type = types.str;
    };

    icon = lib.mkOption {
      type = types.nullOr (
        types.enum (builtins.attrNames cfg.faicons)
      );
      default = null;
      description = "The Font Awesome 5 icon to display next to the profile item.";
    };

    faicons = lib.mkOption {
      description = "A map of icons that can be used to map `network` to a Font Awesome 5 icon.";
      type = types.attrsOf types.str;
      visible = false;
      default = let
        faWrap = icon: "\\faIcon{${icon}}";
      in (
        lib.genAttrs
        [
          "discord"
          "facebook"
          "github"
          "gitlab"
          "inbox"
          "instagram"
          "linkedin"
          "map-marker"
          "map-marker-alt"
          "mastodon"
          "phone"
          "phone*"
          "tiktok"
          "twitch"
          "twitter"
          "user"
          "youtube"
        ]
        (name: faWrap name)
      );
    };

    _out = {
      plaintext = lib.mkOption {
        description = "This modules plaintext output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
      latex = lib.mkOption {
        description = "This modules latex output.";
        type = types.str;
        visible = false;
        internal = true;
        readOnly = true;
      };
    };
  };
  config = {
    _out = {
      plaintext = "";
      latex =
        lib.concatStringsSep
        " "
        (
          lib.flatten
          [
            "\\item"
            (lib.optional (! builtins.isNull cfg.icon) "[${cfg.faicons.${cfg.icon}}]")
            "{${cfg.applyFormat cfg.content}}"
          ]
        );
    };
  };
}
