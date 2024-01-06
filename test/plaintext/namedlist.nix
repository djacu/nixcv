{lib, ...}: let
  testUtils = import ../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      namedlist = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../modules/sections/namedlist.nix
          [
            "basicList"
            "basicListSep"
            "basicAttr"
            "basicAttrSep"
          ]
        );
      };
    };
  };
  config = {
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
}
