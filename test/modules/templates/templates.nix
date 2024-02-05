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
            "complete"
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
            layout = {
              type = "layout";
              documentclass = "article";
              papersize = "letterpaper";
              textwidth = "7in";
              textheight = "9in";
              textsize = "10pt";
              pagestyle = "empty";
            };
            order = [
              "packageSettings"
              "listSettings"
              "environmentSettings"
              "sectionSettings"
              "bibliographySettings"
            ];
            content = {
              packageSettings = {
                type = "templatesContent";
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
                type = "templatesContent";
                enumitem = {
                  nolabelList = {
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
              };

              environmentSettings = {
                type = "templatesContent";
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
                type = "templatesContent";
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
                type = "templatesContent";
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

        complete = {
          templates = {
            layout = {
              type = "layout";
              documentclass = "article";
              papersize = "letterpaper";
              textwidth = "7in";
              textheight = "9in";
              textsize = "10pt";
              pagestyle = "empty";
            };
            order = [
              "packageSettings"
              "glyphSettings"
              "sectionSettings"
              "listSettings"
              "skillsSettings"
              "bibliographySettings"
              "blockquoteSettings"
            ];
            content = {
              packageSettings = {
                type = "templatesContent";
                packages = {
                  # Icons
                  icons = {
                    type = "packages";
                    package = "fontawesome5";
                    packageOptions = [
                      "fixed"
                    ];
                  };

                  # Use regular color names
                  xcolor = {
                    type = "packages";
                    package = "xcolor";
                    packageOptions = [
                      "usenames"
                      "dvipsnames"
                    ];
                  };

                  # multi columns for skills
                  multicol = {
                    type = "packages";
                    package = "multicol";
                    latex = [
                      ''\raggedcolumns''
                      ''\setlength{\columnseprule}{1pt}''
                      ''\setcounter{minrows}{10}''
                    ];
                  };

                  # Font
                  font = {
                    type = "packages";
                    package = "opensans";
                    packageOptions = [
                      "default"
                    ];
                  };

                  # Use utf8
                  utf8 = {
                    type = "packages";
                    package = "inputenc";
                    packageOptions = [
                      "utf8"
                    ];
                  };

                  # custom lists
                  enumitem = {
                    type = "packages";
                    package = "enumitem";
                  };

                  # bibliography
                  biblatex = {
                    type = "packages";
                    package = "biblatex";
                    packageOptions = [
                      ''backend=biber''
                      ''style=ieee''
                      ''defernumbers=true''
                    ];
                    latex = [
                      ''\addbibresource{bibliography.bib}''
                      ''\nocite{*} % force show all entries''
                    ];
                  };

                  # Sections formatting
                  titlesec = {
                    type = "packages";
                    package = "titlesec";
                    packageOptions = [
                      "nobottomtitles*"
                    ];
                  };
                };
              }; # packageSettings

              glyphSettings = {
                type = "templatesContent";
                latex = {
                  glyphtounicode = {
                    type = "rawlatex";
                    latex = ''
                      % Ensure that PDF output is machine readable/ATS parsable
                      \input{glyphtounicode}
                      \pdfgentounicode=1
                      \raggedright % no hyphenated words'';
                  };
                };
              }; # glyphSettings

              sectionSettings = {
                type = "templatesContent";
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
              }; # sectionSettings

              listSettings = {
                type = "templatesContent";
                enumitem = {
                  nolabelList = {
                    type = "enumitem";
                    newlist = {
                      nolabelNew = {
                        type = "newlist";
                        name = "nolabel";
                        parent = "itemize";
                        maxDepth = 4;
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
                  }; # nolabelList

                  minsepList = {
                    type = "enumitem";
                    newlist = [
                      {
                        type = "newlist";
                        name = "minsep";
                        parent = "itemize";
                        maxDepth = 4;
                      }
                    ];
                    setlist = [
                      {
                        type = "setlist";
                        name = "minsep";
                        format = {
                          spacing = {
                            parsep = "0em";
                            itemsep = "0.2em";
                          };
                        };
                      }
                    ];
                  }; # minsepList

                  extraList = {
                    type = "enumitem";
                    newlist = [
                      {
                        type = "newlist";
                        name = "extra";
                        parent = "itemize";
                        maxDepth = 2;
                      }
                    ];
                    setlist = [
                      {
                        type = "setlist";
                        name = "extra";
                        levels = [1];
                      }
                      {
                        type = "setlist";
                        name = "extra";
                        levels = [2];
                        label = ''$\bullet$'';
                        format = {
                          spacing = {
                            rightmargin = "2em";
                          };
                        };
                      }
                    ];
                  }; # extraList
                };
              }; # listSettings

              skillsSettings = {
                type = "templatesContent";
                enumitem = [
                  {
                    type = "enumitem";
                    newlist = {
                      nolabelNew = {
                        type = "newlist";
                        name = "skills";
                        parent = "itemize";
                        maxDepth = 2;
                      };
                    };
                    setlist = [
                      {
                        type = "setlist";
                        name = "skills";
                        format.compact.nosep = true;
                      }
                    ];
                  }
                ];
                latex = [
                  {
                    type = "rawlatex";
                    latex = ''
                      \newcommand{\extraName}[1]{\item\textbf{\large{#1}}}
                      \newcommand{\extraItem}[1]{\item #1}'';
                  }
                ];
                environments = [
                  {
                    type = "newenvironment";
                    name = "skillsEnv";
                    begin = ''
                      \begin{minipage}{\linewidth}
                      \begin{multicols}{2}'';
                    end = ''
                      \end{multicols}
                      \end{minipage}
                      \vspace{2em}'';
                  }
                ];
              }; #skillsSettings

              bibliographySettings = {
                type = "templatesContent";
                latex = [
                  {
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
                      %'';
                  }
                ];
              }; # bibliographySettings

              blockquoteSettings = {
                type = "templatesContent";
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
              }; # blockquoteSettings
            };
          };
        };
      };
    };
  };
}
