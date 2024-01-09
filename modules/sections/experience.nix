{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
  utils = import ../../lib/utils.nix {inherit lib;};
in {
  imports = [
    ../components/roles.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["experience"];
      default = "experience";
      internal = true;
      description = "Type";
    };
    organization = lib.mkOption {
      description = "The name of the organization.";
      type = types.nullOr types.str;
      default = null;
      example = "The NixOS Foundation";
    };
    position = lib.mkOption {
      description = "Your position/title.";
      type = types.nullOr types.str;
      default = null;
      example = "Software Engineer";
    };
    address = lib.mkOption {
      description = "The organization address or place where you worked.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ../components/address.nix
        ];
      });
      default = null;
    };
    url = lib.mkOption {
      description = "The organization website.";
      type = types.nullOr types.str;
      default = null;
      example = "https://nixos.org/";
    };
    dateRange = lib.mkOption {
      description = "The dates at this organization.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ../components/dateRange.nix
        ];
      });
      default = null;
      example = "September 2000";
    };
    summary = lib.mkOption {
      description = "A summary of your work.";
      type = types.nullOr types.str;
      default = null;
    };
    highlights = lib.mkOption {
      description = "Highlights of your work.";
      type = types.nullOr types.str;
      default = null;
    };

    order = lib.mkOption {
      description = "The order of the experience items.";
      type = types.listOf types.str;
      default = [
        "organization"
        "position"
        "address"
        "url"
        "dateRange"
        "summary"
        "highlights"
        "roles"
      ];
    };

    _out.experience = {
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
    cfgItems =
      builtins.removeAttrs
      cfg
      [
        "_module"
        "_outLatex"
        "_outPlaintext"
        "order"
        "type"
      ];
    plaintextOrdered =
      if builtins.isNull cfg.order
      then lib.attrsToList cfgItems
      else
        (
          builtins.map
          (elem: {
            name = elem;
            value = cfgItems.${elem};
          })
          cfg.order
        );
    plaintextFiltered = (
      # remove the nulls
      builtins.filter
      (x: ! builtins.isNull x.value)
      plaintextOrdered
    );
  in {
    _out.experience = {
      plaintext = (
        lib.concatStringsSep
        "\n"
        (
          lib.flatten
          (
            builtins.map
            (
              opt: (
                if builtins.typeOf opt.value == "string"
                then opt.value
                else if
                  # the attrsOf submodule case
                  (
                    (builtins.typeOf opt.value == "set")
                    && (! builtins.hasAttr "_out" opt.value)
                  )
                then
                  # for imported modules, access _out via cfg
                  (
                    lib.mapAttrsToList
                    (name: value: cfg._out.${opt.name}.plaintext)
                    opt.value
                  )
                else
                  # a local submodule like address
                  opt.value._out.${opt.name}.plaintext
              )
            )
            plaintextFiltered
          )
        )
      );
      latex = builtins.trace cfg.roles (
        utils.concatStringsSepFiltered
        "\n"
        ""
        [
          "\\begin{experience}"
          (lib.optionalString (! builtins.isNull cfg.organization) "  \\experienceOrg{${cfg.organization}}")
          "  \\begin{experience}"
          (lib.optionalString (! builtins.isNull cfg.position) "    \\experiencePostion{${cfg.position}}")
          (lib.optionalString (! builtins.isNull cfg.address) "    \\experienceLocation{${cfg.address._out.address.plaintext}}")
          (lib.optionalString (! builtins.isNull cfg.dateRange) "    \\experienceDates{${cfg.dateRange._out.dateRange.plaintext}}")
          (
            lib.concatStringsSep
            "\n"
            (
              lib.mapAttrsToList
              (
                name: value:
                  lib.concatStringsSep
                  "\n"
                  (
                    [
                      "    \\begin{experience}"
                      "      \\experienceRole{${value.role}}"
                    ]
                    ++ (
                      if builtins.isNull value.responsibilities
                      then []
                      else
                        (
                          ["      \\begin{experience}"]
                          ++ (
                            builtins.map
                            (
                              resp: "        \\experienceTask{${resp}}"
                            )
                            value.responsibilities
                          )
                          ++ ["      \\end{experience}"]
                        )
                    )
                    ++ [
                      "    \\end{experience}"
                    ]
                  )
              )
              cfg.roles
            )
          )
          "  \\end{experience}"
          "\\end{experience}"
        ]
      );
    };
  };
}
