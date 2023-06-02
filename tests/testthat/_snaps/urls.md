# Can create a url tibble.

    Code
      dplyr::glimpse(test_result)
    Output
      Rows: 10
      Columns: 11
      $ year      <int> 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018
      $ week      <int> 1, 1, 2, 2, 3, 3, 4, 4, 5, 5
      $ type      <chr> "article", "source", "article", "source", "article", "source~
      $ url       <chr> "https://onlinembapage.com/wp-content/uploads/2016/03/Averag~
      $ scheme    <chr> "https", "https", "https", "http", "https", "https", "https"~
      $ domain    <chr> "onlinembapage", "onlinembapage", "wordpress", "spotrac", "o~
      $ subdomain <chr> NA, NA, "espnfivethirtyeight.files", "www", NA, NA, "data", ~
      $ tld       <chr> "com", "com", "com", "com", "org", "org", "au", "au", "gov",~
      $ path      <chr> "wp-content/uploads/2016/03/AverageTuition_Part1b.jpg", "ave~
      $ query     <list> <NULL>, <NULL>, ["575", "488", "90", "info"], <NULL>, <NULL>~
      $ fragment  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA

