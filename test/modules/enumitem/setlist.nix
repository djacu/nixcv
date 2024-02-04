{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      setlist = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/enumitem/setlist.nix
          [
            "minimal"
            "basic"
            "options1"
            "options2"
            "options3"
            "options4"
          ]
        );
      };
    };
  };
  config = {
    test = {
      setlist = {
        minimal = {
          name = "skills";
        };
        basic = {
          name = "skills";
          levels = [1 2];
          label = ''\textbullet'';
        };
        options1 = {
          name = "skills";
          levels = [1 2];
          label = ''\textbullet'';
          format = {
            spacing = {
              parsep = "0em";
              itemsep = "1em";
            };
          };
        };
        options2 = {
          name = "skills";
          levels = [1 2];
          label = ''\textbullet'';
          format = {
            spacing = {
              leftmargin = "1em";
            };
            compact = {
              nosep = true;
            };
          };
        };
        options3 = {
          name = "references";
          format = {
            penalty = {
              beginpenalty = 10000;
              midpenalty = 10000;
            };
          };
        };
        options4 = {
          name = "references";
          levels = [4];
          label = ''\textbullet'';
          format = {
            spacing = {
              leftmargin = "3em";
              topsep = "0.4em";
              itemindent = "-1em";
              rightmargin = "2em";
            };
          };
        };
      };
    };
  };
}
