{lib, ...}: let
  testUtils = import ../../../lib/test.nix {inherit lib;};
in {
  options = {
    test = {
      cv = lib.mkOption {
        type = (
          testUtils.createTestType
          ../../../modules/top/cv.nix
          [
            "basic"
            "bibliography"
            "template"
          ]
        );
      };
    };
  };
  config = {
    test = {
      cv = rec {
        basic = {
          order = [
            "personal"
            "objective"
            "work-exp"
            "skillsSection"
            "bibliographySection"
            "referencesSection"
          ];
          content = {
            personal = {
              type = "personal";
              order = [
                "name"
                "title"
                "socials"
              ];
              content = {
                name = {
                  type = "text";
                  content = "John Doe";
                  format = {
                    bold = true;
                    size = "Huge";
                  };
                };
                title = {
                  type = "text";
                  content = "Software Developer";
                  format = {
                    size = "Large";
                  };
                };

                socials = {
                  type = "itemlist";
                  order = [
                    "location"
                    "phone"
                    "github"
                  ];
                  content = {
                    location = {
                      type = "profile";
                      content = "Nunya, USA";
                      icon = "map-marker-alt";
                    };
                    phone = {
                      type = "profile";
                      content = "123.456.7890";
                      icon = "phone-alt";
                    };
                    github = {
                      type = "profile";
                      content = "github.com/jdoe";
                      icon = "github";
                    };
                  };
                };
              };
            }; # personal

            objective = {
              type = "section";
              header = "Objective";
              content = {
                objective = {
                  type = "paragraphs";
                  content = [
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sodales molestie justo et convallis. Sed eget ullamcorper metus."
                    ""
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sodales molestie justo et convallis. Sed eget ullamcorper metus."
                  ];
                };
              };
            }; # objective
            work-exp = {
              type = "section";
              header = "Work Experience";
              order = [
                "nixos-foundation"
                "guix-foundation"
              ];
              content = {
                nixos-foundation = {
                  type = "itemlist";
                  order = [
                    "organization"
                    "details"
                  ];
                  content = {
                    organization = {
                      type = "item";
                      content = "The NixOS Foundation";
                      format = {
                        size = "large";
                        bold = true;
                      };
                    };
                    details = {
                      type = "itemlist";
                      order = [
                        "position"
                        "location"
                        "dates"
                        "nix-dev"
                        "web-dev"
                      ];
                      content = {
                        position = {
                          type = "item";
                          content = "Software Engineer";
                          format = {
                            bold = true;
                          };
                        };
                        location = {
                          type = "item";
                          content = "Remote";
                        };
                        dates = {
                          type = "item";
                          content = "2020 - 2023";
                          format = {
                            italic = true;
                          };
                        };
                        nix-dev = {
                          type = "itemlist";
                          content = {
                            _role = {
                              type = "item";
                              content = "Nix Developer";
                            };
                            nix-dev = {
                              type = "itemlist";
                              content = {
                                responsibilities = {
                                  type = "items";
                                  format = {
                                    italic = true;
                                  };
                                  content = [
                                    "I make the Nix."
                                    "I make the flakes."
                                    "I make users cry."
                                  ];
                                };
                              };
                            };
                          };
                        };
                        web-dev = {
                          type = "itemlist";
                          content = {
                            _role = {
                              type = "item";
                              content = "Web Developer";
                            };
                            nix-dev = {
                              type = "itemlist";
                              content = {
                                responsibilities = {
                                  type = "items";
                                  content = [
                                    "I make the Nix site."
                                    "I use HTML and CSS only."
                                  ];
                                };
                              };
                            };
                          };
                        };
                      };
                    };
                  };
                };
                guix-foundation = {
                  type = "itemlist";
                  order = [
                    "organization"
                    "details"
                  ];
                  content = {
                    organization = {
                      type = "item";
                      content = "The Guix Foundation";
                      format = {
                        size = "large";
                        bold = true;
                      };
                    };
                    details = {
                      type = "itemlist";
                      order = [
                        "position"
                        "location"
                        "dates"
                        "nix-dev"
                      ];
                      content = {
                        position = {
                          type = "item";
                          content = "Software Engineer";
                          format = {
                            bold = true;
                          };
                        };
                        location = {
                          type = "item";
                          content = "Remote";
                        };
                        dates = {
                          type = "item";
                          content = "2018 - 2020";
                          format = {
                            italic = true;
                          };
                        };
                        nix-dev = {
                          type = "itemlist";
                          content = {
                            _role = {
                              type = "item";
                              content = "Nix Developer";
                            };
                            nix-dev = {
                              type = "itemlist";
                              content = {
                                responsibilities = {
                                  type = "items";
                                  format = {
                                    italic = true;
                                  };
                                  content = [
                                    "Make new guix things."
                                    "Fix old guix things."
                                  ];
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
            }; # work-exp
            skillsSection = {
              type = "section";
              header = "Skills";
              content = {
                skills = {
                  type = "skills";
                  content = {
                    web-dev = {
                      type = "skill";
                      category = "Web Development";
                      keywords = [
                        "HTML"
                        "CSS"
                        "JavaScript"
                      ];
                    };
                    nix-dev = {
                      type = "skill";
                      category = "Nix Development";
                      keywords = [
                        "Nix"
                        "Nixpkgs"
                        "NixOS"
                      ];
                    };
                    stem = {
                      type = "skill";
                      category = "STEM";
                      keywords = [
                        "Science"
                        "Technology"
                        "Engineering"
                        "Maths"
                      ];
                    };
                  };
                };
              };
            }; # skillsSection
            bibliographySection = {
              type = "section";
              header = "Publications & Talks";
              order = [
                "bibTalks"
                "bibBlogs"
              ];
              content = {
                bibTalks = {
                  type = "bibliography";
                  heading = "subbibliography";
                  title = "Talks";
                  keyword = "talk";
                };
                bibBlogs = {
                  type = "bibliography";
                  heading = "subbibliography";
                  title = "Blogs";
                  keyword = "blog";
                };
              };
            };
            referencesSection = {
              type = "section";
              header = "References";
              content = {
                john-doe = {
                  type = "itemlist";
                  order = [
                    "name"
                    "details"
                  ];
                  content = {
                    name = {
                      type = "item";
                      content = "John Doe";
                      format = {
                        size = "large";
                        bold = true;
                      };
                    };

                    details = {
                      type = "itemlist";
                      order = [
                        "organization"
                        "phone"
                      ];
                      content = {
                        organization = {
                          type = "item";
                          content = "Some Company";
                          format = {
                            bold = true;
                          };
                        };
                        phone = {
                          type = "item";
                          content = "123.456.7890";
                        };
                      };
                    };
                  };
                };
                jane-doe = {
                  type = "itemlist";
                  order = [
                    "name"
                    "details"
                  ];
                  content = {
                    name = {
                      type = "item";
                      content = "Jane Doe";
                      format = {
                        size = "large";
                        bold = true;
                      };
                    };

                    details = {
                      type = "itemlist";
                      order = [
                        "organization"
                        "phone"
                      ];
                      content = {
                        organization = {
                          type = "item";
                          content = "Another Company";
                          format = {
                            bold = true;
                          };
                        };
                        phone = {
                          type = "item";
                          content = "098.765.4321";
                        };
                      };
                    };
                  };
                };
              };
            }; # referencesSection
          };
        }; # basic

        bibliography =
          basic
          // {
            bibresources = {
              someEntry = {
                type = "online";
                entryKey = "use-nix";
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
              someOtherEntry = {
                type = "online";
                entryKey = "use-modules";
                requiredFields = {
                  author = "John Doe";
                  title = "How to use modules";
                  date = "2022-04";
                };
                optionalFields = {
                  language = "english";
                  organization = "NixCon";
                  url = "https://nixcon.org/talks/how-to-use-modules";
                  keywords = "talk,nix,modules";
                };
              };
            };
          };

        template =
          basic
          // {
            templates = {
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
          };
      };
    };
  };
}
