# Can create a url tibble.

    Code
      dplyr::glimpse(test_result)
    Output
      Rows: 10
      Columns: 11
      $ year      <int> 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018
      $ week      <int> 1, 1, 2, 2, 3, 3, 4, 4, 5, 5
      $ type      <chr> "source", "article", "source", "article", "source", "article~
      $ url       <chr> "https://onlinembapage.com/average-tuition-and-educational-a~
      $ scheme    <chr> "https", "https", "http", "https", "https", "https", "https"~
      $ domain    <chr> "onlinembapage", "onlinembapage", "spotrac", "wordpress", "o~
      $ subdomain <chr> NA, NA, "www", "espnfivethirtyeight.files", NA, NA, "data", ~
      $ tld       <chr> "com", "com", "com", "com", "org", "org", "au", "au", "gov",~
      $ path      <chr> "average-tuition-and-educational-attainment-in-the-united-st~
      $ query     <list> <NULL>, <NULL>, <NULL>, ["575", "488", "90", "info"], <NULL>~
      $ fragment  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA

