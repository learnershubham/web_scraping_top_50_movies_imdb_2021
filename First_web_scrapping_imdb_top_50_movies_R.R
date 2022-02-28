install.packages("tidyverse")
install.packages("ggplot2")
install.packages("rvest")
library(tidyverse)
library(rvest)


link = "https://www.imdb.com/list/ls500781427/"
page = read_html(link)
ranking =page %>% html_nodes(".lister-item-index.unbold.text-primary") %>% html_text()
name = page %>% html_nodes(".lister-item-header a") %>% html_text()
movie_link = page %>% html_nodes(".lister-item-header a") %>% html_attr("href") %>% paste("https://www.imdb.com",.,sep="")
year = page %>% html_nodes("span.text-muted.unbold ") %>% html_text()       
rating = page %>% html_nodes(".ipl-rating-star.small .ipl-rating-star__rating")%>% html_text()
scrape_cast = function(movie_link){
  movie_page = read_html(movie_link)
  movie_cast = movie_page %>% html_nodes(".StyledComponents__ActorName-sc-y9ygcu-1.ezTgkS") %>% html_text() %>%
   paste(collapse =",")
  return(movie_cast)
}
cast = sapply(movie_link,FUN = scrape_cast)
top_50_movie_2021 <- data.frame (ranking,name,year,rating,cast)
View(top_50_movie_2021)
