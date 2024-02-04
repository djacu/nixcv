{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      templates = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/templates/default.nix
          [
            "basic"
          ]
        );
      };
    };
  };
  config = {
    test = {
      templates = {
        basic = {
          templates = {
            content = {
              #layout = {
              #  type = "layout";
              #};

              packageSettings = {
                type = "templates";
                packages = {
                  icons = {
                    type = "packages";
                    package = "fontawesome5";
                    packageOptions = [
                      "fixed"
                    ];
                  };
                  enumitem = {
                    type = "packages";
                    package = "enumitem";
                  };
                };
              };

              listSettings = {
                type = "templates";
                enumitem = {
                  type = "enumitem";
                  newlist = {
                    nolabelNew = {
                      type = "newlist";
                      name = "nolabel";
                      parent = "itemize";
                    };
                  };
                  setlist = {
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

              environmentSettings = {
                type = "templates";
                environments = {
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
                };
              };

              sectionSettings = {
                type = "templates";
                titlesec = {
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

              bibliographySettings = {
                type = "templates";
                latex = {
                  rawlatexSettings = {
                    type = "rawlatex";
                    latex = ''
                      % Bibliography indented
                      % https://tex.stackexchange.com/questions/342467/indent-on-printbibliography
                      \defbibenvironment{bibliography}
                      {\list%
                          {%
                              \printtext[labelnumberwidth]{%
                                  \printfield{labelprefix}%
                                  \printfield{labelnumber}%
                              }%
                          }%
                          {%
                              \setlength{\labelwidth}{\labelnumberwidth}%
                              \setlength{\leftmargin}{4em}%
                              \setlength{\labelsep}{\biblabelsep}%
                              \addtolength{\leftmargin}{\labelsep}%
                              \addtolength{\leftmargin}{\leftskip}%<----- here
                              \setlength{\itemsep}{\bibitemsep}%
                              \setlength{\parsep}{\bibparsep}%
                          }%
                          \renewcommand*{\makelabel}[1]{\hss##1}}%
                      {\endlist}
                      {\item}

                      % see \defbibheading def in biblatex docs ~ pg.99
                      % see \titleformat def in titlesec docs ~ pg.4
                      \defbibheading{subbibliography}[\bibname]{%
                          \titleformat{\subsection}{\large\bfseries}{}{}{\hspace{2em}}%
                          \subsection*{#1}%
                      }
                    '';
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
