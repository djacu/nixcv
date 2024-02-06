{
  type = "section";
  header = "Skills";
  content = {
    skills = {
      type = "skills";
      order = [
        "languages"
        "packaging"
        "typesetting"
      ];
      content = {
        languages = {
          type = "skill";
          category = "Languages";
          keywords = [
            "Python"
            "Nix"
            "JavaScript"
            "HTML"
            "CSS"
            "Bash"
          ];
        }; # languages

        packaging = {
          type = "skill";
          category = "Software Packaging";
          keywords = [
            "Nix"
            "Nixpkgs"
            "NixOS"
          ];
        }; # packaging

        typesetting = {
          type = "skill";
          category = "Typesetting";
          keywords = [
            "LaTeX"
          ];
        }; # typesetting
      };
    };
  };
}
