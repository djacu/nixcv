{
  nixcv = {
    education = {
      content = {
        educationSection = import ./sections/education.nix;
      }; # content
      templates = import ../templates/simple.nix;
    }; # generic
  }; # nixcv
}
