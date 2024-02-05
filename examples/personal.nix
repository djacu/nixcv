{lib, ...}: {
  nixcv = {
    personal = {
      content = {
        personalSection = import ./sections/personal.nix;
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
    }; # generic
  }; # nixcv
}
