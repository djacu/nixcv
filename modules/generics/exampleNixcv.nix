{
  nixcv = {
    basic = {
      order = [
        "personal"
        "objective"
        "work-exp"
      ];
      content = {
        personal = import ./examplePersonal.nix;
        objective = import ./exampleParagraph.nix;
        work-exp = import ./exampleSection.nix {};
      };
    };
  };
}
