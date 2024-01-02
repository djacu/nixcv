{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        bib-online = lib.mkOption {
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
              ]
              (
                name:
                  lib.mkOption {
                    type = types.submoduleWith {
                      modules = [../../biblatex/online.nix];
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
        bib-online = {
          basic = {
            entryKey = "example";
            requiredFields = {
              author = "John Doe";
              title = "How to use Nix";
              date = "2022-04";
            };
            optionalFields = {
              language = "English";
              organization = "NixCon";
              url = "https://nixcon.org/talks/how-to-use-nix";
              keywords = "talk,nix";
            };
          };
        };
      };
    };
  };
}
