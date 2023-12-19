{
  basics = {
    name = "Daniel Baker";
    label = "Software Engineer";
    email = "daniel.n.baker@gmail.com";
    phone = "407-474-5339";
    url = "https://djacu.dev/";
    summary = "I love Nix!";
    location = {
      address = "123 Nunya Lane";
      postalCode = "90755";
      city = "Signal Hill";
      countryCode = "US";
      region = "California";
    };
    profiles = [
      {
        network = "Mastodon";
        username = "@djacu";
        url = "https://mastodon.igl.ooo/@djacu";
      }
      {
        network = "LinkedIn";
        username = "dannbaker";
        url = "https://www.linkedin.com/in/dannbaker/";
      }
    ];
  };
  work = [
    {
      organization = "Tweag";
      position = "Software Engineer";
      location = {
        fullAddress = "Remote, USA";
      };
      url = "https://www.tweag.io/";
      startDate = "February 2022";
      endDate = "April 2023";
      roles = [
        {
          role = "jupyenv";
          responsibilities = [
            "Maintainer for an open source project, jupyenv, which provides a Nix-based framework for the definition of declarative and reproducible Jupyter environments."
            "Rewrote the API to provide a better user experience and added several new kernels."
            "Interacted with end users on GitHub and Matrix to resolve their issues and answer questions."
            "Drastically improved the quantity and quality of documentation with the addition of how-to's, tutorials, reference documentation, and Nix options."
            "Created a website, jupyenv.io, to host the newly created documentation and a project blog."
          ];
        }
        {
          role = "Nix Technical Group";
          responsibilities = [
            "Member of the Tweag's Nix technical group."
            "Wrote posts for the Tweag blog demonstrating the capabilities of Nix."
            "Assisted other Tweag employees with Nix questions and technical problems."
            "Created and maintained packages for nixpkgs, the Nix package collection."
          ];
        }
      ];
    }
    {
      organization = "The Aerospace Corporation";
      position = "Senior Member of Technical Staff";
      location = {
        fullAddress = "El Segundo, CA, USA";
      };
      url = "https://aerospace.org/";
      startDate = "July 2020";
      endDate = "February 2022";
      roles = [
        {
          role = "AMIGOS";
          responsibilities = [
            "Member of a software team developing a distributed federated satellite communications simulation tool in Java."
            "Worked with laser physics subject matter experts and scientists to covert their pseudocode into production ready software."
            "Created a rigorous set of regression tests to verify that the newly created software matched the original code to within floating point precision."
            "Created a simple, light-weight, units library to help with units conversions and minimize the chance for errors."
          ];
        }
        {
          role = "Synthetic Aperture Radar";
          responsibilities = [
            "Developed radar signal processing analysis and processing tools."
            "Responsible for code quality and accuracy reviews for multiple programs."
            "Accelerated the use of the latest Python tools and other open source software tools."
            "Mentored and guided new developers in good software practices."
          ];
        }
      ];
    }
  ];
}
