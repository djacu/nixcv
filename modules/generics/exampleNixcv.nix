{
  nixcv = {
    basic = {
      order = [
        "personal"
        "objective"
        "work-exp"
        "skillsSection"
      ];
      content = {
        personal = import ./examplePersonal.nix;
        objective = import ./exampleParagraph.nix;
        work-exp = import ./exampleSection.nix {};
        skillsSection = {
          type = "section";
          header = "Skills";
          content = {
            skills = import ./exampleSkills.nix;
          };
        };
      };
    };
  };
}
