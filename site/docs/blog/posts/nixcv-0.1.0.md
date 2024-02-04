---
draft: false
date: 2024-01-31
description: Announcing the release of nixcv 0.1.0.
authors:
  - djacu
---

# nixcv 0.1.0

## Empower Your CV with nixcv

We're thrilled to announce the initial release of nixcv, a powerful and customizable tool for building your Curriculum Vitae (CV) using Nix expressions.
With version 0.1.0, nixcv provides a foundation for crafting professional CVs effortlessly.
This release marks the beginning of a journey towards simplifying the CV creation process.

---

## The Genesis of nixcv: Simplifying CV Maintenance and Enhancing Compatibility

The birth of nixcv was driven by a pressing need for a more streamlined and sustainable approach to managing CV in the face of evolving job requirements and the challenges posed by Applicant Tracking Systems (ATS).

### Streamlining CV Maintenance

As the job landscape shifted, I found myself tailoring CVs for various positions, resulting in a proliferation of flavor-specific versions.
Each update to the master CV required meticulous changes across all flavors, a daunting and error-prone task.
The process became annoying, time consuming, and untenable.

With nixcv's modular approach, the burden of maintaining multiple CV flavors is lifted.
The use of Nix modules enables effortless composition and merging of flavors, ensuring that updates to the main CV seamlessly propagate to all variations.
This modular architecture not only simplifies maintenance but also empowers users to adapt their CVs to diverse job requirements with ease.

### Confronting ATS Parsing Challenges

The ubiquitous Applicant Tracking Systems posed another challenge—inefficient and incorrect parsing of PDFs.
Recognizing the importance of compatibility with ATS, nixcv addresses this issue by offering a plain text output option.
However, managing different formats and flavors of CVs can be overwhelming.

By decoupling content from the output format and defining a process to create the format, users only need to maintain a singular content configuration.
This approach ensures flexibility, allowing users to effortlessly generate various output products, be it PDFs or plain text, without the hassle of managing multiple versions.

---

## Getting Started: Customizing Your CV

### Writing Your Own Configuration

Tailor your CV to reflect your unique experiences and accomplishments is a breeze with nixcv.
To get started, head to the `examples` directory in the project repository.
Here, you'll find examples that can guide you in creating your own CV.
Create a file in the `examples` directory and write out your configuration.

!!! note
    This method of creating your configuration is not ideal. See below for future feature plans.

### Building Your CV

Build your CV by running the following command in the project's root directory:

```bash
nix build .# <your-cv>
```

---

## What's Next: Future Features

While nixcv 0.1.0 lays a solid foundation, we have exciting plans for the future.
Here's a glimpse of the features we're working on:

### Declarative Templating

Currently, there is a single static template in the repository that builds the PDF.
This is not ideal for extending or modifying styles and environments.
A future release will allow you to declare environments and styles and come with a set of defaults.

### Expanded Bibliography Options

Bibliography entries are currently available but only for the `online` entry type.
This will be expanded in the future to include additional entry types.

### Flake Templates

Currently, you have to clone the repository and add your configuration to the `examples` directory to use nixcv.
A future release will add flake templates that are tied back to the nixcv repo.

---

Thank you for joining us on this exciting launch of nixcv 0.1.0.
We look forward to your feedback and contributions as we continue to refine and expand this tool to meet your evolving needs.
Happy CV building!
