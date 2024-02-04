{lib}: {
  # TODO: still need a way to escape ~, ^, and \ which are fully replaced with \textasciitilde, \textasciicircum, and \textbackslash respectively
  escapeLatex =
    lib.escape
    [
      "&"
      "%"
      "$"
      "#"
      "_"
      "{"
      "}"
    ];
}
