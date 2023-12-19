{
  basics = {
    name = "Daniel Baker";
    label = "Software Engineer";
    email = "daniel.n.baker@gmail.com";
    phone = "407-474-5339";
    url = "https://djacu.dev/";
    summary = ''
      Seeking a full-time role in software engineering, signal processing, scientific data processing, or general analysis.
      I am passionate about creating clear, maintainable, and well tested code and reproducible systems and software.
      Experienced with large scale data processing.
      Experienced with creating production ready software for a variety of scientific algorithms.
      Looking to grow my data processing, application development, and functional programming skills.
      Experienced working in a remote environment and would prefer a remote based role but also willing to work in an office part time.
    '';
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
      location.fullAddress = "Remote, USA";
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
      location.fullAddress = "El Segundo, CA, USA";
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
  volunteer = [
    {
      organization = "Los Angeles County - Department of Public Health";
      position = "Software Engineer";
      location.fullAddress = "Remote, USA";
      startDate = "Februray 2021";
      endDate = "November 2021";
      roles = [
        {
          role = "Front-End Developer";
          responsibilities = [
            "As a volunteer, created a public vaccination dashboard website for the Vaccine Preventable Disease Control Program under LAC DPH that included dynamic maps, time series charts and tables to display residential vaccination data disaggregated by age group, ethnicity, gender, and geographic boundaries."
            "Using Python to distill millions of vaccination entries from the California Immunization Registry into manageable data products that could be served on the website."
            "Using JavaScript along with D3.js, DC.js, CrossFilter.js and DataTables.js to create all of the previously mentioned features."
            "Working with the LAC Epidemiologists to check incoming data integrity and validate the quality of output data products."
            "Spent two months training three DPH employees on JavaScript and how the site functioned so they could take over development."
          ];
        }
      ];
    }
  ];
  education = [
    {
      institution = "University of Southern California";
      url = "https://www.usc.edu/";
      area = "Electrical Engineering";
      studyType = "Master of Science";
      startDate = "August 2016";
      endDate = "May 2018";
    }
    {
      institution = "Rose-Hulman Institute of Technology";
      url = "https://www.rose-hulman.edu/";
      area = "Electrical Engineering";
      studyType = "Bachelor of Science";
      startDate = "August 2004";
      endDate = "May 2008";
      score = "3.45/4.00";
      courses = [
        "DSP System Design"
        "Discrete-Time Control Systems"
      ];
    }
    {
      institution = "Rose-Hulman Institute of Technology";
      url = "https://www.rose-hulman.edu/";
      area = "Applied Mathematics";
      studyType = "Bachelor of Science";
      startDate = "August 2004";
      endDate = "May 2008";
      score = "3.45/4.00";
      courses = [
        "Stochastic Models in Operational Research"
        "Numerical Analysis"
      ];
    }
  ];
}
