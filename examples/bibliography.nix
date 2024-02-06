{lib, ...}: {
  nixcv = {
    bibliography = {
      content = {
        bibliographySection = import ./sections/bibliography.nix;
      }; # content
      templates =
        lib.recursiveUpdate
        (import ../templates/simple.nix)
        {
          content.packageSettings.packages.geometry.packageOptions = [
            "paperheight=3.5in"
            "paperwidth=8.5in"
          ];
        };
      bibresources = import ./sections/bibresouces.nix;
    }; # bibliography
  }; # nixcv
}
