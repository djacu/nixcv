{lib}: rec {
  /*
  Return the permutations of the input.
  All possible orderings, no repeated elements.

  Type: permutations :: [a] -> [[a]]

  Example:
    permutations [1 2 3]
    => [ [ 1 2 3 ] [ 1 3 2 ] [ 2 1 3 ] [ 2 3 1 ] [ 3 1 2 ] [ 3 2 1 ] ]
  */
  permutations = xs:
    if lib.length xs == 0
    then [[]]
    else
      lib.concatMap (
        x: (
          builtins.map
          (p: [x] ++ p)
          (permutations (lib.filter (y: y != x) xs))
        )
      )
      xs;

  /*
  Return all combinations of the input, including the identity.
  Order does not matter, no repeated elements.

  Type: combinations :: [a] -> [[a]]
  Example:
    combinations false ["a" "b" "c"]
    => [ [ ] [ "a" ] [ "b" ] [ "a" "b" ] [ "c" ] [ "a" "c" ] [ "b" "c" ] [ "a" "b" "c" ] ]

    combinations true ["a" "b" "c"]
    => [ [ "a" ] [ "b" ] [ "a" "b" ] [ "c" ] [ "a" "c" ] [ "b" "c" ] [ "a" "b" "c" ] ]
  */
  combinations = noEmpty: xs: let
    addElement = set: element:
      set ++ builtins.map (e: [element] ++ e) set;
    result = builtins.foldl' addElement [[]] xs;
  in
    if noEmpty
    then builtins.tail result # Exclude the empty list from the result
    else result;

  /*
  Return the concatenated permutations of the input.
  All possible orderings, no repeated elements.

  Type: permutations :: [a] -> [a]

  Example:
    permutationsConcat ["a" "b" "c"]
    => [ "abc" "acb" "bac" "bca" "cab" "cba" ]
  */
  permutationsConcat = xs:
    builtins.map
    lib.concatStrings
    (permutations xs);

  /*
  Given a submodule options, return all the parent configuration names.
  Return as a string with each name delimited by a period.

  Type: getSubmoduleParents :: AttrSet -> String

  Example:
    # Given a submodule, date, defined in a config as `nixcv.startDate.date`.
    getSubmoduleParents options
    => "nixcv.startDate"
  */

  getSubmoduleParents = opt:
    lib.concatStringsSep
    "."
    (
      lib.subtractLists
      ["_module" "args"]
      opt._module.args.loc
    );

  /*
  Same as concatStringsSep but filters the list first.

  Type: concatStringsSepFiltered :: string -> any -> [string] -> string

  Example
    concatStringsSepFiltered "," "" ["a" "" "b"]
    => "a,b"
  */
  concatStringsSepFiltered = separator: filter: list:
    lib.concatStringsSep
    separator
    (
      lib.remove
      filter
      list
    );

  /*
  Same as concatStringsSepFiltered but the separator is a new line.
  */
  concatNewlineFiltered = concatStringsSepFiltered "\n";

  /*
  Same as concatStringsSepFiltered but the separator is a comma and space.
  */
  concatCommaFiltered = concatStringsSepFiltered ", ";
}
