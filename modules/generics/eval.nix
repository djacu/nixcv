let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };

  section = pkgs.lib.evalModules {
    modules = [
      ../sections/section.nix
      ./exampleSection.nix
    ];
  };

  nixcv = pkgs.lib.evalModules {
    modules = [
      ../top/nixcv.nix
      ./exampleNixcv.nix
    ];
  };

  skill = pkgs.lib.evalModules {
    modules = [
      ../skills/skill.nix
      ./exampleSkill.nix
    ];
  };

  skills = pkgs.lib.evalModules {
    modules = [
      ../skills/skills.nix
      ./exampleSkills.nix
    ];
  };

  profile = pkgs.lib.evalModules {
    modules = [
      ../lists/profile.nix
      ./exampleProfileItem.nix
    ];
  };

  text = pkgs.lib.evalModules {
    modules = [
      ../text/text.nix
      ./exampleText.nix
    ];
  };

  personal = pkgs.lib.evalModules {
    modules = [
      ../lists/personal.nix
      ./examplePersonal.nix
    ];
  };
in {
  inherit
    nixcv
    personal
    profile
    section
    skill
    skills
    text
    ;
}
