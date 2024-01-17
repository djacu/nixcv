{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      biblatex-online = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/biblatex/online.nix
          [
            "basic"
            "all-options"
          ]
        );
      };
    };
  };
  config = {
    test = {
      biblatex-online = {
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
        all-options = {
          entryKey = "all-options";
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
}
