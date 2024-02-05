{
  nixcv = {
    objective = {
      content = {
        objectiveSection = import ./sections/objective.nix;
      }; # content
      templates = import ../templates/simple.nix;
    }; # objective
  }; # nixcv
}
