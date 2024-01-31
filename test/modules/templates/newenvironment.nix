{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      newenvironment = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/templates/newenvironment.nix
          [
            "minimal"
            "basic"
            "blockquote"
          ]
        );
      };
    };
  };
  config = {
    test = {
      newenvironment = rec {
        minimal = {
          name = "exercise";
        };
        basic =
          minimal
          // {
            begin = ''
              \par\vspace{\baselineskip}\noindent%
              \textbf{Exercise}\begin{itshape}%
              \par\vspace{\baselineskip}\noindent\ignorespaces%
              %'';
            end = ''
              \end{itshape}\ignorespacesafterend%
              %'';
          };
        blockquote = {
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
      };
    };
  };
}
