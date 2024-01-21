{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};

  formatField = {
    content,
    prefix ? "",
    suffix ? "",
    delimiter ? "",
  }:
    prefix + content + suffix + delimiter;

  formatOptionalField = {
    prefix ? "",
    content,
    suffix ? "",
    delimiter ? "",
  } @ inputs: (
    lib.optionalString
    (! builtins.isNull content)
    (formatField inputs)
  );
in {
  imports = [
    ./common.nix
    ../components/standardStringOut.nix
    ../components/bibresourceStringOut.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["online"];
      default = "online";
      description = "Type";
      internal = true;
    };
    requiredFields = {
      author = lib.mkOption {
        type = types.str;
        description = "The author(s) of the `title`.";
      };
      title = lib.mkOption {
        type = types.str;
        description = "The title of the work.";
      };
      date = lib.mkOption {
        type = types.str;
        description = "The publication date.";
      };
    };
    optionalFields = {
      subtitle = lib.mkOption {
        type = types.nullOr types.str;
        description = "The subtitle of the work.";
        default = null;
      };
      titleaddon = lib.mkOption {
        type = types.nullOr types.str;
        description = "An annex to the title.";
        default = null;
      };
      language = lib.mkOption {
        type = types.nullOr types.commas;
        description = "The language(s) of the work. ";
        default = null;
      };
      editor = lib.mkOption {
        type = types.nullOr types.commas;
        description = "The editor(s) of the work.";
        default = null;
      };
      version = lib.mkOption {
        type = types.nullOr types.str;
        description = "The revision number of the work.";
        default = null;
      };
      note = lib.mkOption {
        type = types.nullOr types.str;
        description = "Miscellaneous bibliographic data which does not fit into any other field. The note field may be used to record bibliographic data in a free format.";
        default = null;
      };
      organization = lib.mkOption {
        type = types.nullOr types.str;
        description = "The organization(s) that published a @manual or an @online resource, or sponsored a conference. ";
        default = null;
      };
      url = lib.mkOption {
        type = types.nullOr types.str;
        description = "The URL of an online publication.";
        default = null;
      };
      urldate = lib.mkOption {
        type = types.nullOr types.str;
        description = "The access date of the address specified in the url field.";
        default = null;
      };
      doi = lib.mkOption {
        type = types.nullOr types.str;
        description = "The Digital Object Identifier of the work.";
        default = null;
      };
      eprint = lib.mkOption {
        type = types.nullOr types.str;
        description = "The electronic identifier of an online publication. This is roughly comparable to a `doi` but specific to a certain archive, repository, service, or system.";
        default = null;
      };
      eprintclass = lib.mkOption {
        type = types.nullOr types.str;
        description = "Additional information related to the resource indicated by the `eprinttype` field. This could be a section of an archive, a path indicating a service, a classification of some sort, etc.";
        default = null;
      };
      eprinttype = lib.mkOption {
        type = types.nullOr types.str;
        description = "The type of `eprint` identifier, e.g., the name of the archive, repository, service, or system the `eprint` field refers to";
        default = null;
      };
      addendum = lib.mkOption {
        type = types.nullOr types.str;
        description = "Miscellaneous bibliographic data to be printed at the end of the entry. This is similar to the note field except that it is printed at the end of the bibliography entry.";
        default = null;
      };
      pubstate = lib.mkOption {
        type = types.nullOr types.str;
        description = "The publication state of the work, e.g., 'in press'.";
        default = null;
      };
    };
  };
  config = {
    _out = {
      latex = "";
      plaintext =
        lib.concatStringsSep
        " "
        (
          builtins.filter
          (x: x != "")
          [
            (formatField {
              content = cfg.requiredFields.author;
              delimiter = ".";
            })
            # FIXME: no subtitle or titleaddon
            (formatField {
              content = cfg.requiredFields.title;
              prefix = "\"";
              suffix = "\"";
              delimiter = ".";
            })
            (formatOptionalField {
              content = cfg.optionalFields.language;
              delimiter = ".";
            })
            (formatOptionalField {
              content = cfg.optionalFields.editor;
              delimiter = ",";
            })
            (formatOptionalField {
              content = cfg.optionalFields.version;
              prefix = "Ed. version ";
              delimiter = ",";
            })
            (formatOptionalField {
              content = cfg.optionalFields.note;
              delimiter = ",";
            })
            (formatOptionalField {
              content = cfg.optionalFields.organization;
              delimiter = ".";
            })
            (formatOptionalField {
              content = cfg.optionalFields.eprinttype;
              delimiter = ":";
            })
            (formatOptionalField {
              content = cfg.optionalFields.eprint;
            })
            (formatOptionalField {
              content = cfg.optionalFields.eprintclass;
              prefix = "(";
              suffix = ")";
              delimiter = ".";
            })
            (formatField {
              content = cfg.requiredFields.date;
              prefix = "(";
              suffix = ")";
              delimiter = ",";
            })
            "[Online]."
            (formatOptionalField {
              content = cfg.optionalFields.url;
              prefix = "Available: ";
            })
            (formatOptionalField {
              content = cfg.optionalFields.urldate;
              prefix = "(";
              suffix = ")";
              delimiter = ".";
            })
            (formatOptionalField {
              content = cfg.optionalFields.addendum;
              delimiter = ",";
            })
            (formatOptionalField {
              content = cfg.optionalFields.pubstate;
              delimiter = ".";
            })
          ]
        );
      bibliography = let
        allFields = (
          lib.filterAttrs
          (name: value: ! builtins.isNull value)
          (cfg.requiredFields // cfg.optionalFields)
        );
        mappedFields = (
          lib.mapAttrsToList
          (name: value: "${name} = {${value}}")
          allFields
        );
      in
        (
          lib.concatStringsSep
          ",\n  "
          (["@online{${cfg.entryKey}"] ++ mappedFields)
        )
        + ",\n}";
    };
  };
}
