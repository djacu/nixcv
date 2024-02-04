{lib}: {
  /*
  Specialized function for combining attribute sets of options based on some predicate.
  Initial use case was for combining formatting options for the setlist module.

  Assumes the attrset has some `_out` key and removes it.
  The options will be combined at the end with a comma and space.
  The do-nothing return for the predicate is an empty string; it will be removed.

  Type: combineOptions :: AttrSet -> Function -> String

  Example:
    (
      combineOptions
      { nosep = true; noitemsep = true; }
      (
        name: value:
          if value
          then name
          else ""
      )
    )
    => "nosep, noitemsep"

  */
  combineOptions = predicate: configuration: (
    lib.concatStringsSep
    ", "
    (
      lib.remove
      ""
      (
        lib.mapAttrsToList
        predicate
        (
          builtins.removeAttrs
          configuration
          ["_out"]
        )
      )
    )
  );
}
