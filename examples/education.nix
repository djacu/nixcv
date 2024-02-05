{lib, ...}: {
  nixcv = {
    education = {
      content = {
        educationSection = import ./sections/education.nix;
      }; # content
      templates =
        lib.recursiveUpdate
        (import ../templates/simple.nix)
        {
          content.packageSettings.packages.geometry.packageOptions = [
            "paperheight=3in"
            "paperwidth=8.5in"
          ];
        };
    }; # generic
  }; # nixcv
}
