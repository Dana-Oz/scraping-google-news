# loading the packages:
library(dplyr) # for pipes and the data_frame function
library(rvest) # webscraping
install
library(stringr) # to deal with strings and to clean up our data
# extracting the whole website
google <- read_html("https://news.google.com/")
# extracting the com vehicles
# we pass the nodes in html_nodes and extract the text from the last one 
# we use stringr to delete strings that are not important
vehicle_all <- google %>% 
  html_nodes("div div div main c-wiz div div div article div div div") %>% 
  html_text() %>%
  str_subset("[^more_vert]") %>%
  str_subset("[^share]") %>%
  str_subset("[^bookmark_border]")

vehicle_all[1:10] # take a look at the first ten
##  [1] "The New York Times"  "Vox.com"             "Wall Street Journal"
##  [4] "The New York Times"  "Opinion"             "Opinion"            
##  [7] "The Washington Post" "Opinion"             "Opinion"            
## [10] "CNN"
# extracting the time elapsed
time_all <- google %>% html_nodes("div article div div time") %>% html_text()

time_all[1:10] # take a look at the first ten
##  [1] "2 hours ago"  "today"        "4 hours ago"  "yesterday"   
##  [5] "yesterday"    "2 hours ago"  "today"        "one hour ago"
##  [9] "one hour ago" "today"
# extracting the headlines
# and using stringr for cleaning
headline_all <- google %>% html_nodes("article") %>% html_text("span") %>%
  str_split("(?<=[a-z0-9!?\\.])(?=[A-Z])")
# str_split("(?<=[a-z0-9αινσϊ!?\\.])(?=[A-Z])") # for Google News in Portuguese

headline_all <- sapply(headline_all, function(x) x[1]) # extract only the first elements


headline_all[1:10] 