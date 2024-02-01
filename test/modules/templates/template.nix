{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      template = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/templates/template.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      template = {
        basic = {
          template = {
            blockquote = {
              type = "newenvironment";
              name = "blockquote";
              begin = ''
                % https://tex.stackexchange.com/questions/97782/combining-leftskip-rightskip-and-raggedright
                \par%
                \medskip%
                \leftskip=2.5em%
                \advance\csname @rightskip\endcsname 2em \advance\rightskip 2em%
                %\rightskip=2em % switch above to this for justified and hyphenated right
                \noindent%
                \ignorespaces%
                %'';
              end = ''
                \par%
                \medskip%
                \ignorespacesafterend%
                %'';
            };
            sectionFormat = {
              type = "titleformat";
              command = ''\section'';
              shape = "hang";
              format = ''\LARGE\bfseries'';
              label = "";
              sep = "0em";
              before-code = ''\MakeUppercase'';
              after-code = ''\color{black}\titlerule'';
            };
            nolabelList = {
              type = "enumitem";
              content = {
                nolabelNew = {
                  type = "newlist";
                  name = "nolabel";
                  parent = "itemize";
                };
                nolabelOpt1 = {
                  type = "setlist";
                  name = "nolabel";
                  levels = [1];
                  format = {
                    spacing = {
                      parsep = "0em";
                      itemsep = "1em";
                    };
                  };
                };
                nolabelOpt2 = {
                  type = "setlist";
                  name = "nolabel";
                  levels = [2];
                  format = {
                    spacing = {
                      leftmargin = "1em";
                    };
                    compact = {
                      nosep = true;
                    };
                  };
                };
                nolabelOpt3 = {
                  type = "setlist";
                  name = "nolabel";
                  levels = [3];
                  format = {
                    spacing = {
                      leftmargin = "1.2em";
                      topsep = "0.9em";
                    };
                  };
                };
                nolabelOpt4 = {
                  type = "setlist";
                  name = "nolabel";
                  levels = [4];
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
        };
      };
    };
  };
}
