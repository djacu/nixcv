{lib, ...}: {
  nixcv = {
    skills = {
      content = {
        skillsSection = import ./sections/skills.nix;
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
    }; # generic
  }; # nixcv
}
