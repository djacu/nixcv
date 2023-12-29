{lib, ...}: let
  inherit (lib) types;
  utils = import ../../modules/utils.nix {inherit lib;};

  major = [
    ./basic.nix
  ];
  minor = [
    ./order.nix
  ];

  allCombos =
    builtins.map
    lib.flatten
    (
      builtins.map
      builtins.attrValues
      (
        lib.cartesianProductOfSets {
          major = utils.combinations true major;
          minor = utils.combinations false minor;
        }
      )
    );
  pathToFileName = x:
    lib.removeSuffix
    ".nix"
    (
      lib.last (
        builtins.split
        "/"
        (builtins.toString x)
      )
    );

  fileNames =
    builtins.map
    (
      combo:
        lib.concatStringsSep
        "-"
        (
          builtins.map
          pathToFileName
          combo
        )
    )
    allCombos;

  allImports =
    builtins.map
    (combo: {imports = [combo];})
    allCombos;

  #allConfigs = lib.zipListsWith (a: b: {${a} = b;}) fileNames allImports;
  allConfigs =
    builtins.listToAttrs
    (
      lib.zipListsWith (a: b: {
        name = a;
        value = b;
      })
      fileNames
      allImports
    );
in {
  inherit
    allCombos
    fileNames
    allImports
    allConfigs
    ;
}
#{
#  options = {
#    personal = lib.mkOption {
#      type = types.submodule {
#        options = (
#          lib.genAttrs
#          (builtins.attrNames allConfigs)
#          (
#            name:
#              lib.mkOption {
#                type = types.submoduleWith {
#                  modules = [../../modules/sections/personal.nix];
#                };
#              }
#          )
#        );
#      };
#    };
#  };
#  config = {
#    personal = allConfigs;
#  };
#}

