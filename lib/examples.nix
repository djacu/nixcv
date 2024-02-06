{
  self,
  system,
  pkgs,
  lib,
}: rec {
  getFilestem = path: ext: lib.removeSuffix ext (builtins.baseNameOf path);
  replaceSuffix = path: old: new: (lib.removeSuffix old path) + new;

  relPathWithParent = parent: path:
    (builtins.baseNameOf parent)
    + (
      lib.removePrefix
      (builtins.toString parent)
      (builtins.toString path)
    );

  removeTemplates = config:
    builtins.mapAttrs
    (
      name: value: (
        # nixcv
        builtins.mapAttrs
        (
          name: value:
          # nixcv.<name>
            builtins.removeAttrs
            value
            ["templates"]
        )
        value
      )
    )
    config;

  getFilteredFiles = {
    inputPath ? self + "/examples",
    pathFilter ? [
      "sections"
      "generic"
    ],
    ...
  }: (
    lib.foldl'
    (
      filelist: blacklist: (
        builtins.filter
        (x: ! lib.hasInfix blacklist (builtins.toString x))
        filelist
      )
    )
    (lib.filesystem.listFilesRecursive inputPath)
    pathFilter
  );

  extractExampleConfig = path: let
    example = import path;
    example' =
      if (builtins.typeOf example == "lambda")
      then example {inherit lib;}
      else example;
  in
    lib.generators.toPretty
    {}
    (
      removeTemplates
      example'
    );

  pathToExampleInfo = {
    inputPath ? self + "/examples",
    inputExt ? "nix",
    outputExt ? "md",
    ...
  }: path: rec {
    oldFilename = builtins.baseNameOf path;
    newFilename = replaceSuffix oldFilename inputExt outputExt;

    outFilePath = "${outParentDir}${newFilename}";
    outParentDir = lib.removeSuffix oldFilename (relPathWithParent inputPath path);
    outPdfDir = outParentDir + filestem;
    filestem = builtins.unsafeDiscardStringContext (getFilestem path ("." + inputExt));

    pdfDerivation = self.packages.${system}."example-${filestem}";

    markdownContent = ''
      ```nix
      ${config}
      ```

      ${jinja}
    '';
    config = extractExampleConfig path;
    jinja = ''
      {% with pdf_file = "./document.pdf" %}

      <object data="{{ pdf_file }}" type="application/pdf" width="100%" style="height: calc(50vh);">
        <embed src="{{ pdf_file }}" type="application/pdf">
          <p>
            This browser does not support PDFs.
            Here is a download link:
            <a href="{{ pdf_file }}" class="image fit">Download</a>
          </p>
        </embed>
      </object>

      {% endwith %}
    '';
  };

  copyExamplesToNixStore = example:
    pkgs.runCommand
    "nixcv-example-documentation"
    {}
    ''
      mkdir $out
      ${
        (
          lib.concatStringsSep
          "\n"
          (
            builtins.map
            (
              opt: ''
                mkdir -p $out/${opt.outParentDir}
                touch $out/${opt.outFilePath}
                echo ${lib.escapeShellArg opt.markdownContent} > $out/${opt.outFilePath}
                mkdir -p $out/${opt.outPdfDir}
                cp ${opt.pdfDerivation}/* $out/${opt.outPdfDir}/
              ''
            )
            example
          )
        )
      }
    '';

  generateExamplesDocumentation = args:
    copyExamplesToNixStore
    (
      builtins.map
      (pathToExampleInfo args)
      (getFilteredFiles args)
    );
  copyExampleDocs =
    pkgs.writeShellScriptBin
    "copy-example-docs"
    ''
      #!/usr/bin/env bash
      nix build .\#examplePdfDocs
      # remove the old examples but keep the index.md file
      find site/docs/examples/ ! -name 'index.md' -type f -exec rm -f {} +
      cp -r ./result/* ./site/docs/
      chmod +w -R ./site/docs/examples
    '';
}
