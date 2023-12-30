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
    (builtins.baseNameOf x);

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
    lib.attrsets.mergeAttrsList
    (
      builtins.map
      (
        x:
          builtins.map
          (y: import y {})
          x
      )
      allCombos
    );

  allConfigs =
    builtins.listToAttrs
    (
      lib.zipListsWith (a: b: {
        name = a;
        value = {personal.content.${a} = b;};
        #value = {personal.content = b;};
      })
      fileNames
      allImports
    );
in
  # blah
  {
    inherit
      #    allCombos
      fileNames
      #allImports
      
      allConfigs
      ;
  }
#{
#  personal-example = lib.evalModules {
#    modules = [
#      {
#        options = {
#          personal = lib.mkOption {
#            type = types.submodule {
#              options = (
#                lib.genAttrs
#                #(builtins.attrNames allConfigs)
#                fileNames
#                (
#                  name:
#                    lib.mkOption {
#                      type = types.submoduleWith {
#                        modules = [../../modules/sections/personal.nix];
#                      };
#                    }
#                )
#              );
#            };
#          };
#        };
#        #config = {
#        #  personal = allConfigs;
#        #};
#        config = allConfigs;
#        #config = {
#        #  personal = {
#        #    basic = {};
#        #    basic-order = {};
#        #  };
#        #};
#      }
#    ];
#  };
#}

