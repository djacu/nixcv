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
    {
      organization = "Raytheon";
      position = "Senior Systems Engineer";
      location.fullAddress = "El Segundo, CA, USA";
      url = "https://www.rtx.com/";
      startDate = "November 2014";
      endDate = "July 2020";
      roles = [
        {
          role = "SOLDIER";
          responsibilities = [
            "Lead developer on a year long research and development effort implementing a radar signal processing algorithm."
            "Leveraged the distributed computing capabilities of PySpark in an AWS EMR environment."
            "Effort concluded with the customer being completely satisfied and a robust algorithm ready for deployment as part of a larger radar signal processing pipeline."
          ];
        }
        {
          role = "BELLAGIO";
          responsibilities = [
            "Key developer and systems engineering for an agile, behavior-driven, multi-contractor, radar signal processing development effort on AWS."
            "Made significant contributions to requirement flow down and mapping, feature development, software architecture, coding, and testing."
            "Worked with radar signal processing subject matter experts to convert pseudocode into production ready software."
            "Worked on several specialized radar signal processing algorithms."
          ];
        }
        {
          role = "DRACO";
          responsibilities = [
            "Responsible for the integrating, testing, and characterizing a gimbal stabilized platform for a space payload."
            "Created specialized tests to capture nanoradian angular movements in order to develop a high fidelity friction model."
            "Planned and built a test system and prepared test procedures for future production units."
          ];
        }
        {
          role = "MFEOIR";
          responsibilities = [
            "Modeled a high-friction, low-inertia fluid rotary unit (FRU) with high fidelity gearing and friction."
            "Designed a non-linear control algorithm to command the FRU to follow a decoupled gimbal."
            "Used Matlab to auto-generate the controls algorithm code for the embedded system."
          ];
        }
        {
          role = "MFL";
          responsibilities = [
            "Responsible for designing and modeling an infrared auto-alignment loop."
            "Created high fidelity models for fast steering mirros and an infrared sensor."
          ];
        }
        {
          role = "NGJ";
          responsibilities = [
            "Modeled the rigid body dynamics, sensors and actuators for a door controlled ram air turbine."
            "Worked with mechanical designers to incorporate a flexible body model into the simulation."
          ];
        }
        {
          role = "JTO";
          responsibilities = [
            "Worked with multiple functional roles to architect, design, integrate, and test a power supply and a communications module."
            "Created thermal and electrical simulations and analyses to drive design decisions."
            "Mentored other junior engineers on good system and mechanical design."
          ];
        }
      ];
    }
    {
      organization = "DRS Sensors & Targeting Systems";
      position = "Senior Systems Engineer";
      location.fullAddress = "Cypress, CA, USA";
      url = "https://www.leonardodrs.com/";
      startDate = "June 2008";
      endDate = "November 2014";
      roles = [
        {
          role = "Full Lifecycle Engineer";
          responsibilities = [
            "Responsible for designing, integrating, testing, fielding and supporting LRIP of multiple gimbal stabilized platforms."
            "Modeling, analysis and design of control algorithms for a gimbal and isolator stabilized EO/IR system using MATLAB/SIMULINK."
            "Responsible for integrating, calibrating and testing the sensor and actuator hardware for stabilized platforms."
            "Derive algorithms for target location and geo-pointing including the use of Euler angles and quaternion rotations."
          ];
        }
        {
          role = "Systems Analysis";
          responsibilities = [
            "Responsible for first principles based synthetic imagery generation, modeling and analysis."
            "Create complex urban scenery including using Blender."
            "Apply material properties and render synthetic imagery for visible, infrared, hyperspectral and LIDAR systems using DIRSIG and supporting tools."
            "Process raw imagery for analysis and exploitation algorithms using MATLAB and correlate results to real-world phenomenology."
            "Rigid body and multi-body simulation using Newtonian mechanics."
          ];
        }
        {
          role = "Systems Engineer";
          responsibilities = [
            "Well versed with the roles and duties of a System Engineer."
            "Performed requirements decomposition and allocation and developed specifications, processes and metrics."
            "Performed analysis, modeling and trade studies at all levels and of the total system product."
            "Prepared for and participated in program milestone events."
          ];
        }
      ];
    }
  ];
  volunteer = [
    {
      organization = "Los Angeles County: Department of Public Health";
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
  skills = [
    {
      name = "Languages";
      keywords = [
        "Python"
        "Java"
        "Nix"
        "JavaScript"
        "HTML"
        "CSS"
        "Bash"
        "Matlab"
      ];
    }
    {
      name = "Software Packaging";
      keywords = [
        "Nix"
        "Nixpkgs"
        "NixOS"
        "C toolchain"
        "Go toolchain"
        "Python toolchain"
      ];
    }
    {
      name = "Domains";
      keywords = [
        "Software Engineering"
        "Functional Programming"
        "Applied Mathematics"
        "Signal Processing"
        "Image Processing"
        "Synthetic Aperture Radar"
        "Feedback Controls"
        "Algorithms"
        "Estimation"
        "Modeling"
        "Analysis"
      ];
    }
    {
      name = "Stabilized Platforms";
      keywords = [
        "Gimbals"
        "Classic Controls"
        "Newtonian Mechanics"
        "Rigid Body Dynamics"
        "Flexible Body Dynamics"
        "Geo-Pointing"
        "Quaternions"
        "Euler Angles"
      ];
    }
    {
      name = "Network";
      keywords = [
        "Layer 2/3 using pfSense and Ubiquiti"
        "VLAN configuration and routing"
        "OpenVPN"
        "Tailscale"
        "WireGuard"
      ];
    }
    {
      name = "Front-End Web";
      keywords = [
        "HTML"
        "CSS"
        "JavaScript"
        "Astro"
        "Tailwind"
      ];
    }
    {
      name = "Operating Systems";
      keywords = [
        "Arch"
        "BSD"
        "CentOS"
        "Linux"
        "NixOS"
        "RHEL"
        "Ubuntu"
        "ZFS"
        "Btrfs"
      ];
    }
    {
      name = "DevOps";
      keywords = [
        "Bash Scripting"
        "Git"
        "CI/CD"
        "GitHub Actions"
        "Jenkins"
        "Nginx"
        "NixOS"
        "Docker"
        "Virtualization"
        "SSH"
        "Linode"
        "Netlify"
      ];
    }
    {
      name = "Test";
      keywords = [
        "Hypothesis"
        "Pytest"
      ];
    }
    {
      name = "Typesetting";
      keywords = [
        "LaTeX"
      ];
    }
  ];
}
