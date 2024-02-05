{
  nixcv = {
    personal = {
      content = {
        personalSection = import ./sections/personal.nix;
      }; # content
      templates = import ../templates/simple.nix;
    }; # generic
  }; # nixcv
}
