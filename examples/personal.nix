{
  nixcv = {
    personal = {
      content = {
        personalSection = import ./sections/personal.nix;
      }; # content
      templates = {
        templateFile = ../latex/cv.tex;
      };
    }; # generic
  }; # nixcv
}
