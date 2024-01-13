let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };

  section = pkgs.lib.evalModules {
    modules = [
      ./section.nix
      ./exampleSection.nix
    ];
  };

  nixcv = pkgs.lib.evalModules {
    modules = [
      ./nixcv.nix
      ./exampleNixcv.nix
    ];
  };

  skill = pkgs.lib.evalModules {
    modules = [
      ./skill.nix
      ./exampleSkill.nix
    ];
  };

  skills = pkgs.lib.evalModules {
    modules = [
      ./skills.nix
      ./exampleSkills.nix
    ];
  };

  profile = pkgs.lib.evalModules {
    modules = [
      ./profile.nix
      ./exampleProfileItem.nix
    ];
  };

  text = pkgs.lib.evalModules {
    modules = [
      ./text.nix
      ./exampleText.nix
    ];
  };

  personal = pkgs.lib.evalModules {
    modules = [
      ./personal.nix
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
