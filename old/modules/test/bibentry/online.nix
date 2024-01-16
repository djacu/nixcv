{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    nixcv = {
      test = {
        online = lib.mkOption {
          type = types.submodule {
            options = (
              lib.genAttrs
              [
                "basic"
                "alloptions"
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
        online = {
          basic = {
            entryKey = "basic";
            requiredFields = {
              author = "John Doe";
              title = "How to use Nix";
              date = "2022-04";
            };
            optionalFields = {
              language = "english";
              organization = "NixCon";
              url = "https://nixcon.org/talks/how-to-use-nix";
              keywords = "talk,nix";
            };
          };
          alloptions = {
            entryKey = "alloptions";
            requiredFields = {
              author = "John Doe";
              title = "How to use Nix";
              date = "2022-04";
            };
            optionalFields = {
              subtitle = "The most gentle intro";
              titleaddon = "A store of reproducibility.";
              language = "english";
              editor = "Jane Doe";
              version = "0.1.0";
              note = "Nothing of note here!";
              organization = "NixCon";
              url = "https://nixcon.org/talks/how-to-use-nix";
              urldate = "2023-01-15";
              doi = "10.1234/example-doi";
              eprint = "arXiv:1234.5678";
              eprintclass = "cs.AI";
              eprinttype = "preprint";
              addendum = "Additional Information";
              pubstate = "forthcoming";
              keywords = "talk,nix";
            };
          };
        };
      };
    };
  };
}
