{
  nixcv = {
    basic = {
      sections = {
        objective = import ./exampleParagraph.nix;
        work-exp = import ./exampleSection.nix {};
      };
    };
  };
}
