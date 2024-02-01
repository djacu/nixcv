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
          };
        };
      };
    };
  };
}
