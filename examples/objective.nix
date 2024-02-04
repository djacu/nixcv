{
  nixcv = {
    objective = {
      content = {
        objectiveSection = import ./sections/objective.nix;
      }; # content
      templates = {
        templateFile = ../latex/cv.tex;
      };
    }; # objective
  }; # nixcv
}
