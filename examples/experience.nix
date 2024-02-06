{lib, ...}: {
  nixcv = {
    experience = {
      content = {
        experienceSection = import ./sections/experience.nix;
      }; # content
      templates =
        lib.recursiveUpdate
        (import ../templates/simple.nix)
        {
          content.packageSettings.packages.geometry.packageOptions = [
            "paperheight=3.8in"
            "paperwidth=8.5in"
          ];
        };
    }; # generic
  }; # nixcv
}
