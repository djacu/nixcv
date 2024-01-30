{
  self,
  pkgs,
  lib,
}: rec {
  /*
  Get a list of all files in a directory filtered by infix values.

  # Attrset Arguments

  - modulesDir : Path
      Directory to search for files.
  - pathFilter : [String]
      Keywords to search for anywhere in the paths and remove from the result.

  # Type

  ```
  getFilteredFiles :: Attrset -> [String]
  ```

  # Example

  ```nix
  getFilteredFiles {modulesDir = self + ./modules; pathFilter = ["component"];}
  => [
      "/nix/store/.../modules/biblatex/bibliography.nix",
      "/nix/store/.../modules/biblatex/bibresources.nix",
      "/nix/store/.../modules/biblatex/common.nix",
      ...
      "/nix/store/.../modules/text/text.nix",
      "/nix/store/.../modules/top/cv.nix",
      "/nix/store/.../modules/top/nixcv.nix"
    ]
  ```
  */
  getFilteredFiles = {
    modulesDir ? self + "/modules",
    pathFilter ? [
      "enumitem" # TODO - remove when ready
      "component"
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
    (lib.filesystem.listFilesRecursive modulesDir)
    pathFilter
  );

  /*
  Generate metadata for an module give a configuration attrset and a path to the module.

  # Attrset Arguments
  - modulesDir : Path
      Directory to search for files.
  - moduleExt : String
      The extension of the module file.
  - moduleDocsExt : String
      The extension of the file that the resulting module documentation will go into.

  # Type

  ```
  pathToModuleInfo :: Attrset -> Path -> Attrset
  ```

  # Example

  ```nix
  pathToModuleInfo {} (self + ./modules/top/nixcv.nix)
  => {
      "filestem": "nixcv",
      "header": "# nixcv",
      "newFilename": "nixcv.md",
      "oldFilename": "nixcv.nix",
      "options": "... <a bunch of text> ...",
      "optionsContent": "## nixcv\n\n ... <a bunch of text> ...",
      "outFilePath": "modules/top/nixcv.md",
      "outParentDir": "modules/top/",
      "path": "/nix/store/.../modules/top/nixcv.nix"
    }
  ```
  */
  pathToModuleInfo = {
    modulesDir ? self + "/modules",
    moduleExt ? "nix",
    moduleDocsExt ? "md",
    ...
  }: path: rec {
    inherit path;
    oldFilename = builtins.baseNameOf path;
    newFilename = replaceSuffix oldFilename moduleExt moduleDocsExt;
    filestem = getFilestem path ("." + moduleExt);

    outFilePath = "${outParentDir}${newFilename}";
    outParentDir = lib.removeSuffix oldFilename (relPathWithParent modulesDir path);

    options = (
      lib.concatStringsSep
      "\n\n"
      [
        header
        optionsContent
      ]
    );
    header = "# ${filestem}";
    optionsContent =
      lib.foldl'
      (acc: func: func acc)
      path
      [
        pathToDocList
        externalOptions
        (builtins.map optionToMarkdown)
        (builtins.map removeTrailingNewlines)
        (lib.concatStringsSep "\n\n")
      ];
  };

  /*
  Get the stem (i.e. the file name without the extension) given a path and extension.

  # Type

  ```
  getFilestem :: path -> str -> str
  ```

  # Example

  ```nix
  getFilestem ./modules/top/nixcv.nix ".nix"
  => "nixcv"
  ```
  */
  getFilestem = path: ext: lib.removeSuffix ext (builtins.baseNameOf path);

  /*
  Get the relative path, as a string, truncated to but including a parent directory.

  # Type

  ```
  relPathWithParent :: path -> path -> str
  ```

  Example

  ```nix
  relPathWithParent ./modules/top ./modules/top/nixcv.nix
  => "top/nixcv.nix"
  ```
  */
  relPathWithParent = parent: path:
    (builtins.baseNameOf parent)
    + (
      lib.removePrefix
      (builtins.toString parent)
      (builtins.toString path)
    );

  /*
  Replaces a suffix with a new one.

  # Type

  ```
  replaceSuffix :: str -> str -> str -> str
  ```

  # Example

  ```nix
  replaceSuffix "nixcv.nix" "nix" "md"
  => "nixcv.md"
  ```
  */
  replaceSuffix = path: old: new: (lib.removeSuffix old path) + new;

  /*
  Given a module path, generates the option metadata in an attrset.

  # Type

  ```
  pathToDocList :: Path -> Module Option Attrset
  ```
  */
  pathToDocList = path:
    lib.optionAttrSetToDocList (
      (
        lib.evalModules {
          modules = [
            path
          ];
        }
      )
      .options
    );

  /*
  Determines whether a module option should be removed or not.

  Returns False if an option:
  - Is not visible.
  - Is internal.
  - Has the string "_module" in its name.

  # Type

  ```
  externalOptions :: Attrset -> boolean
  ```
  */
  externalOptions = (
    builtins.filter
    (
      opt: (
        opt.visible
        && ! opt.internal
        && ! lib.hasInfix "_module" opt.name
      )
    )
  );

  /*
  Given module option metadata, create a markdown representation.

  # Type

  ```
  optionToMarkdown :: Attrset -> String
  ```
  */
  optionToMarkdown = (
    opt: ''
      ## ${opt.name}

      ${opt.description}

      *Type*: ${opt.type}

      ${
        lib.optionalString
        (lib.hasAttr "default" opt)
        ''
          *Default*:

          ```nix
          ${opt.default.text}
          ```
        ''
      }
      ${
        lib.optionalString
        (lib.hasAttr "example" opt)
        ''
          *Example*:

          ```nix
          ${opt.example.text}
          ```
        ''
      }
    ''
  );

  /*
  Remove trailing newlines from a string.

  # Type

  ```
  removeTrailingNewlines :: str -> str
  ```

  # Example

  ```nix
  removeTrailingNewlines "some text\n\n\n"
  => "some text"
  ```
  */
  removeTrailingNewlines = (
    str: (
      if lib.hasSuffix "\n" str
      then removeTrailingNewlines (lib.removeSuffix "\n" str)
      else str
    )
  );

  /*
  Give a list of metadata for module options, copy the markdown documentation to the nix store.

  # Type

  ```
  copyMarkdownToNixStore :: [Attrset] -> Derivation
  ```
  */
  copyMarkdownToNixStore = options:
    pkgs.runCommand
    "nixcv-options-markdown"
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
                echo ${lib.escapeShellArg opt.options} > $out/${opt.outFilePath}
              ''
            )
            options
          )
        )
      }
    '';

  /*
  Create documentation given a path to modules. Will recursively find all files.

  # Attrset Arguments
  - modulesDir : Path
      Directory to search for files.
  - pathFilter : [String]
      Keywords to search for anywhere in the paths and remove from the result.
  - moduleExt : String
      The extension of the module file.
  - moduleDocsExt : String
      The extension of the file that the resulting module documentation will go into.
  */
  generateMarkdownDocumentation = args:
    copyMarkdownToNixStore
    (
      builtins.map
      (pathToModuleInfo args)
      (getFilteredFiles args)
    );
}
