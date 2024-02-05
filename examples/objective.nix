{lib, ...}: {
  nixcv = {
    objective = {
      content = {
        objectiveSection = import ./sections/objective.nix;
      }; # content
      templates =
        lib.recursiveUpdate
        (import ../templates/simple.nix)
        {
          content.packageSettings.packages.geometry.packageOptions = [
            "paperheight=2.5in"
            "paperwidth=8.5in"
          ];
        };
    }; # objective
  }; # nixcv
}
