{
  nixcv = {
    education = {
      content = {
        educationSection = import ./sections/education.nix;
      }; # content
      templates = {
        templateFile = ../latex/cv.tex;
      };
    }; # generic
  }; # nixcv
}
