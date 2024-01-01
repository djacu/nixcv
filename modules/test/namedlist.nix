{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        namedlist = lib.mkOption {
          description = "A named list entry.";
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basicList"
                "basicListSep"
                "basicAttr"
                "basicAttrSep"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../sections/namedlist.nix];
                    };
                  }
              )
            );
          };
        };
      };
    };
  };
  config = {
    nixcv = {
      test = {
        namedlist = rec {
          basicList = {
            name = "FOSS";
            items = [
              "Contributor to nixpkgs."
              "On the NixOS foundation board."
            ];
          };
          basicListSep =
            basicList
            // {
              nameSep = "\n~~~\n";
              label = "•";
              itemsSep = "\n~~~\n";
            };
          basicAttr = {
            name = "FOSS";
            items = {
              "000" = "Contributor to nixpkgs.";
              "001" = "On the NixOS foundation board.";
            };
          };
          basicAttrSep =
            basicAttr
            // {
              nameSep = "\n~~~\n";
              label = "•";
              itemsSep = "\n~~~\n";
            };
        };
      };
    };
  };
}
