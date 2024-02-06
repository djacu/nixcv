{
  type = "section";
  header = "Publications & Talks";
  order = [
    "talks"
    "papers"
  ];
  content = {
    talks = {
      type = "bibliography";
      heading = "subbibliography";
      title = "Talks";
      keyword = "talk";
    };
    papers = {
      type = "bibliography";
      heading = "subbibliography";
      title = "Papers";
      keyword = "papers";
    };
  }; # content
}
