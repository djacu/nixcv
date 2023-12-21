{
  nixcv = {
    startDate = {
      year = 2021;
      month = 11;
      day = 4;
      sep = ".";
      order = "dmy";
    };
    endDate = {
      year = 2023;
      month = 12;
      day = 14;
      order = "ymd";
      monthFormat = "long";
      _months.foo = {
        short = {"1" = "blah";};
        long = {"1" = "bleh";};
      };
    };
  };
}
