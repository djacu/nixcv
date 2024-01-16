{
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  cfg = config;
in {
  imports = [
    ../components/profiles.nix
  ];
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["personal"];
      default = "personal";
      internal = true;
      description = "Type";
    };
    name = lib.mkOption {
      description = "Your full name.";
      type = types.nullOr types.str;
      default = null;
      example = "Johnathan Doe";
    };
    label = lib.mkOption {
      description = "Your job title or general field of expertise.";
      type = types.nullOr types.str;
      default = null;
      example = "Programmer";
    };
    email = lib.mkOption {
      description = "Your email.";
      type = types.nullOr types.str;
      default = null;
      example = "john@doe.com";
    };
    phone = lib.mkOption {
      description = "Your phone number.";
      type = types.nullOr types.str;
      default = null;
      example = "(123) 456-7890";
    };
    address = lib.mkOption {
      description = "Your address information.";
      type = types.nullOr (types.submoduleWith {
        modules = [
          ../components/address.nix
        ];
      });
      default = null;
    };

    order = lib.mkOption {
      description = "The order of the profile items.";
      type = types.listOf types.str;
      default = [
        "name"
        "label"
        "address"
        "phone"
        "email"
        "profiles"
      ];
    };

    _out.personal = {
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
  config = let
    cfgItems =
      builtins.removeAttrs
      cfg
      [
        "_module"
        "_out"
        "order"
        "profileOrder"
        "sep"
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
    _out.personal = {
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
                  # the attrsOf submodule case like profiles
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
      latex = let
        nameAndLabel = [
          (lib.optionalString (! builtins.isNull cfgItems.name) "\\textbf{\\Huge ${cfg.name}}\n")
          (lib.optionalString (! builtins.isNull cfgItems.label) "{\\Large\\vspace{0.7em}\\hspace{0.3em} ${cfg.label}}\n")
        ];
        profileItems = (
          lib.mapAttrsToList
          (
            opt: value: (
              if opt == "address"
              then "  \\profileItem{\\faIcon{map-marker-alt}}{${value._out.address.plaintext}}"
              else if opt == "phone"
              then "  \\profileItem{\\faIcon{phone-alt}}{${value}}"
              else if opt == "email"
              then "  \\profileItem{\\faIcon{inbox}}{${value}}"
              else if opt == "profiles"
              then
                lib.concatStringsSep
                "\n"
                (
                  lib.mapAttrsToList
                  (name: value: value._out.social.latex)
                  value
                )
              else
                throw ''
                  Something is wrong in the personal module.
                  I probably got a bad order or there is an option not being filtered.
                  I got an opt: ${opt} and value: ${lib.strings.escapeNixString value}.
                ''
            )
          )
          (
            # these are handled separately
            builtins.removeAttrs
            cfgItems
            ["name" "label"]
          )
        );
        profileItemsWrapped =
          if (builtins.length profileItems == 0)
          then profileItems
          else
            (
              ["\\begin{profile}"]
              ++ profileItems
              ++ ["\\end{profile}"]
            );
      in (
        lib.concatStringsSep
        "\n"
        (nameAndLabel ++ profileItemsWrapped)
      );
    };
  };
}
