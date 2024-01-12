{
  nixcv = {
    basic = {
      content = {
        objective = import ./exampleParagraph.nix;
        work-exp = import ./exampleSection.nix {};
      };
    };
  };
}
