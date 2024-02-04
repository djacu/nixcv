{
  nixcv = {
    generic = {
      order = [
        "personalSection"
        "objectiveSection"
        "educationSection"
        "workExperienceSection"
        "volunteerExperienceSection"
        "extraSection"
        "skillsSection"
        "bibliographySection"
        "referencesSection"
      ];
      content = {
        personalSection = {
          type = "personal";
          order = [
            "name"
            "socials"
          ];
          content = {
            name = {
              type = "text";
              content = "Daniel Baker";
              format = {
                bold = true;
                size = "Huge";
              };
            };
            socials = {
              type = "itemlist";
              latexEnvironment = "minsep";
              order = [
                "location"
                "phone"
                "email"
                "linkedin"
                "github"
                "personalSite"
              ];
              content = {
                location = {
                  type = "profile";
                  content = "Signal Hill, CA, USA";
                  icon = "map-marker-alt";
                };
                phone = {
                  type = "profile";
                  content = "+1 407 474 5339";
                  icon = "phone-alt";
                };
                email = {
                  type = "profile";
                  content = "daniel.n.baker@gmail.com";
                  icon = "inbox";
                };
                linkedin = {
                  type = "profile";
                  content = "linkedin.com/in/dannbaker";
                  icon = "linkedin";
                };
                github = {
                  type = "profile";
                  content = "github.com/djacu";
                  icon = "github";
                };
                personalSite = {
                  type = "profile";
                  content = "djacu.dev";
                  icon = "user";
                };
              }; # content
            }; # socials
          }; # content
        }; # personalSection

        objectiveSection = {
          type = "section";
          header = "Objective";
          content = {
            objective = {
              type = "paragraphs";
              content = [
                ''
                  Seeking a full-time role in software engineering, signal processing, scientific data processing, or general analysis.
                  I am passionate about creating clear, maintainable, and well tested code and reproducible systems and software.
                  Experienced with large scale data processing.
                  Experienced with creating production ready software for a variety of scientific algorithms.
                  Looking to grow my data processing, application development, and functional programming skills.
                  Experienced working in a remote environment and would prefer a remote based role but also willing to work in an office part time.
                ''
              ];
            };
          };
        }; # objectiveSection

        educationSection = {
          type = "section";
          header = "Education";
          order = [
            "usc-ms-ee"
            "rhit-bs-ee"
            "rhit-bs-ma"
          ];
          content = {
            usc-ms-ee = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "University of Southern California";
                  format = {
                    bold = true;
                    size = "large";
                  };
                }; # organization
                details = {
                  type = "itemlist";
                  order = [
                    "degree"
                    "location"
                    "dates"
                  ];
                  content = {
                    degree = {
                      type = "item";
                      content = "Master of Science in Electrical Engineering";
                      format = {
                        bold = true;
                      };
                    }; # degree
                    location = {
                      type = "item";
                      content = "Los Angeles, California, USA";
                    }; # location
                    dates = {
                      type = "item";
                      content = "August 2016 -- May 2018";
                      format = {
                        italic = true;
                      };
                    }; # dates
                  }; # content
                }; # details
              }; # content
            }; # usc-ms-ee

            rhit-bs-ee = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "Rose-Hulman Institute of Technology";
                  format = {
                    bold = true;
                    size = "large";
                  };
                }; # organization
                details = {
                  type = "itemlist";
                  order = [
                    "degree"
                    "location"
                    "dates"
                  ];
                  content = {
                    degree = {
                      type = "item";
                      content = "Bachelor of Science in Electrical Engineering";
                      format = {
                        bold = true;
                      };
                    }; # degree
                    location = {
                      type = "item";
                      content = "Terre Haute, Indiana, USA";
                    }; # location
                    dates = {
                      type = "item";
                      content = "August 2004 -- May 2008";
                      format = {
                        italic = true;
                      };
                    }; # dates
                  }; # content
                }; # details
              }; # content
            }; # rhit-bs-ee

            rhit-bs-ma = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "Rose-Hulman Institute of Technology";
                  format = {
                    bold = true;
                    size = "large";
                  };
                }; # organization
                details = {
                  type = "itemlist";
                  order = [
                    "degree"
                    "location"
                    "dates"
                  ];
                  content = {
                    degree = {
                      type = "item";
                      content = "Bachelor of Science in Applied Mathematics";
                      format = {
                        bold = true;
                      };
                    }; # degree
                    location = {
                      type = "item";
                      content = "Terre Haute, Indiana, USA";
                    }; # location
                    dates = {
                      type = "item";
                      content = "August 2004 -- May 2008";
                      format = {
                        italic = true;
                      };
                    }; # dates
                  }; # content
                }; # details
              }; # content
            }; # rhit-bs-ma
          }; # content
        }; # educationSection

        workExperienceSection = {
          type = "section";
          header = "Experience";
          order = [
            "tweag"
            "aero"
            "raytheon"
            "drs"
          ];
          content = {
            tweag = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "Tweag";
                  format = {
                    bold = true;
                    size = "large";
                  };
                }; # organization
                details = {
                  type = "itemlist";
                  order = [
                    "title"
                    "location"
                    "dates"
                    "jupyenv"
                    "nixgroup"
                  ];
                  content = {
                    title = {
                      type = "item";
                      content = "Software Engineer";
                      format = {
                        bold = true;
                      };
                    }; # title
                    location = {
                      type = "item";
                      content = "USA";
                    }; # location
                    dates = {
                      type = "item";
                      content = "February 2022 -- April 2023";
                      format = {
                        italic = true;
                      };
                    }; # dates
                    jupyenv = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "jupyenv";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Maintainer for an open source project, jupyenv, which provides a Nix-based framework for the definition of declarative and reproducible Jupyter environments."
                                "Rewrote the API to provide a better user experience and added several new kernels."
                                "Interacted with end users on GitHub and Matrix to resolve their issues and answer questions."
                                "Drastically improved the quantity and quality of documentation with the addition of how-to's, tutorials, reference documentation, and Nix options."
                                "Created a website, jupyenv.io, to host the newly created documentation and a project blog."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # jupyenv
                    nixgroup = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Nix Technical Group";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Member of the Tweag's Nix technical group."
                                "Wrote posts for the Tweag blog demonstrating the capabilities of Nix."
                                "Assisted other Tweag employees with Nix questions and technical problems."
                                "Created and maintained packages for nixpkgs, the Nix package collection."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # nixgroup
                  }; # content
                }; # details
              }; # content
            }; # tweag

            aero = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "The Aerospace Corporation";
                  format = {
                    bold = true;
                    size = "large";
                  };
                }; # organization
                details = {
                  type = "itemlist";
                  order = [
                    "title"
                    "location"
                    "dates"
                    "amigos"
                    "sar"
                  ];
                  content = {
                    title = {
                      type = "item";
                      content = "Senior Member of Technical Staff";
                      format = {
                        bold = true;
                      };
                    }; # title
                    location = {
                      type = "item";
                      content = "El Segundo, CA, USA";
                    }; # location
                    dates = {
                      type = "item";
                      content = "July 2020 -- February 2022";
                      format = {
                        italic = true;
                      };
                    }; # dates

                    amigos = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "AMIGOS";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Member of a software team developing a distributed federated satellite communications simulation tool in Java."
                                "Worked with laser physics subject matter experts and scientists to convert their pseudocode into production ready software."
                                "Created a rigorous set of regression tests to verify that the newly created software matched the original code to within floating point precision."
                                "Created a simple, light-weight, units library to help with units conversions and minimize the chance for errors."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # amigos

                    sar = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Synthetic Aperture Radar";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Developed radar signal processing analysis and processing tools."
                                "Responsible for code quality and accuracy reviews for multiple programs."
                                "Accelerated the use of the latest Python tools and other open source software tools."
                                "Mentored and guided new developers in good software practices."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # sar
                  }; # content
                }; # details
              }; # content
            }; # aero

            raytheon = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "Raytheon";
                  format = {
                    bold = true;
                    size = "large";
                  };
                }; # organization
                details = {
                  type = "itemlist";
                  order = [
                    "title"
                    "location"
                    "dates"
                    "soldier"
                    "bellagio"
                    "draco"
                    "mfeoir"
                    "mfl"
                    "ngj"
                    "jto"
                  ];
                  content = {
                    title = {
                      type = "item";
                      content = "Senior Systems Engineer";
                      format = {
                        bold = true;
                      };
                    }; # title
                    location = {
                      type = "item";
                      content = "El Segundo, CA, USA";
                    }; # location
                    dates = {
                      type = "item";
                      content = "November 2014 -- July 2020";
                      format = {
                        italic = true;
                      };
                    }; # dates

                    soldier = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "SOLDIER";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Lead developer on a year long research and development effort implementing a radar signal processing algorithm."
                                "Leveraged the distributed computing capabilities of PySpark in an AWS EMR environment."
                                "Effort concluded with the customer being completely satisfied and a robust algorithm ready for deployment as part of a larger radar signal processing pipeline."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # soldier

                    bellagio = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "BELLAGIO";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Key developer and systems engineering for an agile, behavior-driven, multi-contractor, radar signal processing development effort on AWS."
                                "Made significant contributions to requirement flow down and mapping, feature development, software architecture, coding, and testing."
                                "Worked with radar signal processing subject matter experts to convert pseudocode into production ready software."
                                "Worked on several specialized radar signal processing algorithms."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # bellagio

                    draco = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "DRACO";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Responsible for the integrating, testing, and characterizing a gimbal stabilized platform for a space payload."
                                "Created specialized tests to capture nanoradian angular movements in order to develop a high fidelity friction model."
                                "Planned and built a test system and prepared test procedures for future production units."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # draco

                    mfeoir = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "MFEOIR";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Modeled a high-friction, low-inertia fluid rotary unit (FRU) with high fidelity gearing and friction."
                                "Designed a non-linear control algorithm to command the FRU to follow a decoupled gimbal."
                                "Used Matlab to auto-generate the controls algorithm code for the embedded system."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # mfeoir

                    mfl = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "MFL";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Responsible for designing and modeling an infrared auto-alignment loop."
                                "Created high fidelity models for fast steering mirros and an infrared sensor."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # mfl

                    ngj = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "NGJ";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Modeled the rigid body dynamics, sensors and actuators for a door controlled ram air turbine."
                                "Worked with mechanical designers to incorporate a flexible body model into the simulation."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # ngj

                    jto = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "JTO";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Worked with multiple functional roles to architect, design, integrate, and test a power supply and a communications module."
                                "Created thermal and electrical simulations and analyses to drive design decisions."
                                "Mentored other junior engineers on good system and mechanical design."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # jto
                  }; # content
                }; # details
              }; # content
            }; # raytheon

            drs = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "DRS Sensors & Targeting Systems";
                  format = {
                    bold = true;
                    size = "large";
                  };
                }; # organization
                details = {
                  type = "itemlist";
                  order = [
                    "title"
                    "location"
                    "dates"
                    "fle"
                    "systems-analysis"
                    "systems-engineering"
                  ];
                  content = {
                    title = {
                      type = "item";
                      content = "Senior Systems Engineer";
                      format = {
                        bold = true;
                      };
                    }; # title
                    location = {
                      type = "item";
                      content = "Cypress, CA, USA";
                    }; # location
                    dates = {
                      type = "item";
                      content = "June 2008 -- November 2014";
                      format = {
                        italic = true;
                      };
                    }; # dates

                    fle = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Full Lifecycle Engineering";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Responsible for designing, integrating, testing, fielding and supporting LRIP of multiple gimbal stabilized platforms."
                                "Modeling, analysis and design of control algorithms for a gimbal and isolator stabilized EO/IR system using MATLAB/SIMULINK."
                                "Responsible for integrating, calibrating and testing the sensor and actuator hardware for stabilized platforms."
                                "Derive algorithms for target location and geo-pointing including the use of Euler angles and quaternion rotations."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # fle

                    systems-analysis = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Systems Analysis";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Responsible for first principles based synthetic imagery generation, modeling and analysis."
                                "Create complex urban scenery including using Blender."
                                "Apply material properties and render synthetic imagery for visible, infrared, hyperspectral and LIDAR systems using DIRSIG and supporting tools."
                                "Process raw imagery for analysis and exploitation algorithms using MATLAB and correlate results to real-world phenomenology."
                                "Rigid body and multi-body simulation using Newtonian mechanics."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # systems-analysis

                    systems-engineering = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Systems Engineering";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "Well versed with the roles and duties of a System Engineer."
                                "Performed requirements decomposition and allocation and developed specifications, processes and metrics."
                                "Performed analysis, modeling and trade studies at all levels and of the total system product."
                                "Prepared for and participated in program milestone events."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # systems-engineering
                  }; # content
                }; # details
              }; # content
            }; # aero
          }; # content
        }; # workExperienceSection

        volunteerExperienceSection = {
          type = "section";
          header = "Volunteer";
          order = [
            "lacdph"
          ];
          content = {
            lacdph = {
              type = "itemlist";
              order = [
                "organization"
                "details"
              ];
              content = {
                organization = {
                  type = "item";
                  content = "Los Angeles County - Department of Public Health";
                  format = {
                    bold = true;
                    size = "large";
                  };
                }; # organization
                details = {
                  type = "itemlist";
                  order = [
                    "title"
                    "location"
                    "dates"
                    "frontend"
                  ];
                  content = {
                    title = {
                      type = "item";
                      content = "Software Engineer";
                      format = {
                        bold = true;
                      };
                    }; # title
                    location = {
                      type = "item";
                      content = "USA";
                    }; # location
                    dates = {
                      type = "item";
                      content = "February 2021 -- November 2021";
                      format = {
                        italic = true;
                      };
                    }; # dates
                    frontend = {
                      type = "itemlist";
                      content = {
                        _role = {
                          type = "item";
                          content = "Front-End Developer";
                        };
                        responsibilities = {
                          type = "itemlist";
                          content = {
                            responsibilities = {
                              type = "items";
                              content = [
                                "As a volunteer, created a public vaccination dashboard website for the Vaccine Preventable Disease Control Program under LAC DPH that included dynamic maps, time series charts and tables to display residential vaccination data disaggregated by age group, ethnicity, gender, and geographic boundaries."
                                "Using Python to distill millions of vaccination entries from the California Immunization Registry into manageable data products that could be served on the website."
                                "Using JavaScript along with D3.js, DC.js, CrossFilter.js and DataTables.js to create all of the previously mentioned features."
                                "Working with the LAC Epidemiologists to check incoming data integrity and validate the quality of output data products."
                                "Spent two months training three DPH employees on JavaScript and how the site functioned so they could take over development."
                              ];
                            };
                          };
                        }; # responsibilities
                      }; # content
                    }; # frontend
                  }; # content
                }; # details
              }; # content
            }; # lacdph
          }; # content
        }; # volunteerExperienceSection

        extraSection = {
          type = "section";
          header = "Extra";
          order = [
            "foss"
            "personal"
          ];
          content = {
            foss = {
              type = "itemlist";
              latexEnvironment = "extra";
              order = [
                "header"
                "details"
              ];
              content = {
                header = {
                  type = "item";
                  content = "FOSS";
                  format = {
                    bold = true;
                    size = "large";
                  };
                };
                details = {
                  type = "itemlist";
                  latexEnvironment = "extra";
                  content = {
                    details = {
                      type = "items";
                      content = [
                        "Contributor to nixpkgs and maintainer for several packages submitted."
                        "Submitted a PR to nixpkgs to add an IP library to the standard library."
                        "On the program committee for SCaLE (Southern California Linux Expo) and organizer of the Immutable and Reproducible software track."
                        "On the program committee for NixCon NA."
                        "Co-Founder of the SoCal Nix Users Group in Southern California (socal-nug.com)."
                      ];
                    };
                  };
                };
              }; # content
            }; # foss

            personal = {
              type = "itemlist";
              latexEnvironment = "extra";
              order = [
                "header"
                "details"
              ];
              content = {
                header = {
                  type = "item";
                  content = "Personal";
                  format = {
                    bold = true;
                    size = "large";
                  };
                };
                details = {
                  type = "itemlist";
                  latexEnvironment = "extra";
                  content = {
                    details = {
                      type = "items";
                      content = [
                        "Run my own Lemmy and Mastodon instance on NixOS on Linode."
                        "Maintain a managed network at home including a pfSense router and Ubiquiti switches and access point."
                        "Maintain my own Unraid server and currently working on building up a NixOS server."
                      ];
                    };
                  };
                };
              }; # content
            }; # personal
          }; # content
        }; # extraSection

        skillsSection = {
          type = "section";
          header = "Skills";
          content = {
            skills = {
              type = "skills";
              order = [
                "languages"
                "packaging"
                "domains"
                "controls"
                "network"
                "front-end-web"
                "oses"
                "devops"
                "test"
                "typesetting"
              ];
              content = {
                languages = {
                  type = "skill";
                  category = "Languages";
                  keywords = [
                    "Python"
                    "Java"
                    "Nix"
                    "JavaScript"
                    "HTML"
                    "CSS"
                    "Bash"
                    "Matlab"
                  ];
                }; # languages

                packaging = {
                  type = "skill";
                  category = "Software Packaging";
                  keywords = [
                    "Nix"
                    "Nixpkgs"
                    "NixOS"
                    "C toolchain"
                    "Go toolchain"
                    "Python toolchain"
                  ];
                }; # packaging

                domains = {
                  type = "skill";
                  category = "Domains";
                  keywords = [
                    "Software Engineering"
                    "Functional Programming"
                    "Applied Mathematics"
                    "Signal Processing"
                    "Image Processing"
                    "Synthetic Aperture Radar"
                    "Feedback Controls"
                    "Algorithms"
                    "Estimation"
                    "Modeling"
                    "Analysis"
                  ];
                }; # domains

                controls = {
                  type = "skill";
                  category = "Stabilized Platforms";
                  keywords = [
                    "Gimbals"
                    "Classic Controls"
                    "Newtonian Mechanics"
                    "Rigid Body Dynamics"
                    "Flexible Body Dynamics"
                    "Geo-Pointing"
                    "Quaternions"
                    "Euler Angles"
                  ];
                }; # controls

                network = {
                  type = "skill";
                  category = "Network";
                  keywords = [
                    "Layer 2/3 using pfSense and Ubiquiti"
                    "VLAN configuration and routing"
                    "OpenVPN"
                    "Tailscale"
                    "WireGuard"
                  ];
                }; # network

                front-end-web = {
                  type = "skill";
                  category = "Front-End Web";
                  keywords = [
                    "HTML"
                    "CSS"
                    "JavaScript"
                    "Astro"
                    "Tailwind"
                  ];
                }; # front-end-web

                oses = {
                  type = "skill";
                  category = "Operating Systems";
                  keywords = [
                    "Arch"
                    "BSD"
                    "CentOS"
                    "Linux"
                    "NixOS"
                    "RHEL"
                    "Ubuntu"
                    "ZFS"
                    "Btrfs"
                  ];
                }; # oses

                devops = {
                  type = "skill";
                  category = "DevOps";
                  keywords = [
                    "Bash Scripting"
                    "Git"
                    "CI/CD"
                    "GitHub Actions"
                    "Jenkins"
                    "Nginx"
                    "NixOS"
                    "Docker"
                    "Virtualization"
                    "SSH"
                    "Linode"
                    "Netlify"
                  ];
                }; # devops

                test = {
                  type = "skill";
                  category = "Test";
                  keywords = [
                    "Hypothesis"
                    "Pytest"
                  ];
                }; # test

                typesetting = {
                  type = "skill";
                  category = "Typesetting";
                  keywords = [
                    "LaTeX"
                  ];
                }; # typesetting
              }; # content
            }; # skills
          }; # content
        }; # skillsSection

        bibliographySection = {
          type = "section";
          header = "Publications & Talks";
          order = [
            "talks"
            "blogs"
          ];
          content = {
            talks = {
              type = "bibliography";
              heading = "subbibliography";
              title = "Talks";
              keyword = "talk";
            };
            blogs = {
              type = "bibliography";
              heading = "subbibliography";
              title = "Blogs";
              keyword = "blog";
            };
          }; # content
        }; #bibliographySection

        referencesSection = {
          type = "section";
          header = "References";
          order = [
            "brugioni"
            "chan"
            "harbaugh"
            "hollenbeck"
          ];
          content = {
            brugioni = {
              type = "itemlist";
              order = [
                "name"
                "details"
              ];
              content = {
                name = {
                  type = "item";
                  content = "John Brugioni";
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
                      content = "The Aerospace Corporation";
                      format = {
                        bold = true;
                      };
                    };
                    phone = {
                      type = "item";
                      content = "703.850.7281";
                    };
                  };
                }; # details
              }; # content
            }; # brugioni

            chan = {
              type = "itemlist";
              order = [
                "name"
                "details"
              ];
              content = {
                name = {
                  type = "item";
                  content = "Cliff Chan";
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
                      content = "The Aerospace Corporation";
                      format = {
                        bold = true;
                      };
                    };
                    phone = {
                      type = "item";
                      content = "626.244.1180";
                    };
                  };
                }; # details
              }; # content
            }; # chan

            harbaugh = {
              type = "itemlist";
              order = [
                "name"
                "details"
              ];
              content = {
                name = {
                  type = "item";
                  content = "Kent Harbaugh";
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
                      content = "Raytheon";
                      format = {
                        bold = true;
                      };
                    };
                    phone = {
                      type = "item";
                      content = "818.632.9795";
                    };
                  };
                }; # details
              }; # content
            }; # harbaugh

            hollenbeck = {
              type = "itemlist";
              order = [
                "name"
                "details"
              ];
              content = {
                name = {
                  type = "item";
                  content = "Matt Hollenbeck";
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
                      content = "AMD";
                      format = {
                        bold = true;
                      };
                    };
                    phone = {
                      type = "item";
                      content = "925.808.5139";
                    };
                  };
                }; # details
              }; # content
            }; # hollenbeck
          }; # content
        }; # referencesSection
      }; # content

      bibresources = {
        nixcon2022 = {
          type = "online";
          entryKey = "nixcon2022";
          requiredFields = {
            author = "Daniel Baker";
            title = "jupyterWith: Making Jupyter Reproducible";
            date = "2022-10";
          };
          optionalFields = {
            url = "https://www.youtube.com/watch?v=hx4fQOjgg3U";
            language = "english";
            organization = "NixCon";
            keywords = "talk,conference,nixcon,nix,jupyter,jupyenv";
          };
        }; # nixcon2022

        jupyenv010 = {
          type = "online";
          entryKey = "jupyenv010";
          requiredFields = {
            author = "Daniel Baker";
            title = "Announcing jupyenv 0.1.0";
            date = "2023-02";
          };
          optionalFields = {
            url = "https://www.tweag.io/blog/2023-02-02-jupyenv-0-1-0/";
            language = "english";
            organization = "Tweag";
            keywords = "blog,tweag,nix,jupyter,jupyenv";
          };
        }; # jupyenv010

        jupyterwithNext = {
          type = "online";
          entryKey = "jupyterwithNext";
          requiredFields = {
            author = "Daniel Baker";
            title = "Jupyterwith next";
            date = "2022-11";
          };
          optionalFields = {
            url = "https://www.tweag.io/blog/2022-11-17-jupyter-with-next/";
            language = "english";
            organization = "Tweag";
            keywords = "blog,tweag,nix,jupyter,jupyenv";
          };
        }; # jupyterwithNext

        unittestnix = {
          type = "online";
          entryKey = "unittestnix";
          requiredFields = {
            author = "Daniel Baker";
            title = "Unit Test Your Nix Code";
            date = "2022-09";
          };
          optionalFields = {
            url = "https://www.tweag.io/blog/2022-09-01-unit-test-your-nix-code/";
            language = "english";
            organization = "Tweag";
            keywords = "blog,tweag,nix";
          };
        }; # unittestnix
      }; # bibresources
      templates = {
        templateFile = ../latex/cv.tex;
      };
    }; # generic
  };
}
