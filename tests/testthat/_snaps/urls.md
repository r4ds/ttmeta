# Can create a url tibble.

    Code
      test_result
    Output
      # A tibble: 10 x 11
          year  week type    url      scheme domain subdomain tld   path  query       
         <int> <int> <fct>   <chr>    <fct>  <chr>  <chr>     <chr> <chr> <list>      
       1  2018     1 article https:/~ https  onlin~ <NA>      com   wp-c~ <NULL>      
       2  2018     1 source  https:/~ https  onlin~ <NA>      com   aver~ <NULL>      
       3  2018     2 article https:/~ https  wordp~ espnfive~ com   2017~ <named list>
       4  2018     2 source  http://~ http   spotr~ www       com   rank~ <NULL>      
       5  2018     3 article https:/~ https  ourwo~ <NA>      org   what~ <NULL>      
       6  2018     3 source  https:/~ https  ourwo~ <NA>      org   <NA>  <NULL>      
       7  2018     4 article https:/~ https  gov    data      au    data~ <named list>
       8  2018     4 source  https:/~ https  gov    data      au    data~ <named list>
       9  2018     5 source  https:/~ https  census factfind~ gov   face~ <NULL>      
      10  2018     5 source  https:/~ https  kaggle www       com   muon~ <NULL>      
      # i 1 more variable: fragment <chr>

