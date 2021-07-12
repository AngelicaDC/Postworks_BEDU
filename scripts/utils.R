readRenviron('~/.Renviron')
B.PATH <- Sys.getenv('BEDU_PATH')
setwd(paste(B.PATH, 'data', sep=''))

library(dplyr)

get_fname <- function(url) {
  paste(tail(strsplit(url, '/')[[1]], 2)[1], 
        tail(strsplit(url, '/')[[1]], 1)[1],
        sep='')
}

download_urls <- function(urls) {
  files <- unlist(lapply(urls, get_fname))
  missing <- !(files %in% dir())
  
  if (length(urls[missing]) > 0) {
    download.file(
      url = urls[missing], 
      destfile = files[missing],
      mode = 'wb')
  }
}

urls_to_df <- function(urls, cols=c(
  "Date", "HomeTeam", "AwayTeam", "FTHG", "FTAG", "FTR"
)) {
  
  download_urls(urls)

  datos <- lapply(unlist(lapply(urls, get_fname)), read.csv)
  datos <- lapply(datos, select, cols)

  updFmt <- function(ds) {
    d2d <- unlist(lapply(ds$Date, nchar))
    
    if (sum(d2d == 8) > 0) {
      ds$Date[d2d == 8] = format(as.Date(ds$Date[d2d == 8], '%d/%m/%y'), '%d/%m/%Y')
    }
    
    mutate(ds,
             Date=as.Date(ds$Date, '%d/%m/%Y'))
  }

  # print(head(datos[[1]]))
  # print(head(datos[[3]]))
  datos <- lapply(datos, updFmt)
  
  print(head(datos[[1]]))
  print(head(datos[[3]]))
  datos <- do.call(rbind, datos)
  rename(datos, casa=FTHG, visitante=FTAG)
}
