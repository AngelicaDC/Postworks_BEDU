library(dplyr)

data <- read.csv(paste(
  'https://raw.githubusercontent.com/beduExpert/',
  'Programacion-R-Santander-2021/main/Sesion-06/Postwork/match.data.csv',
  sep=''
  ))

data <- mutate(data, sumagoles=home.score+away.score)
head(data)

# Agrupar
data <- mutate(data, 
               sm.date=format(as.Date(date), '%Y-%m'),
               date=as.Date(date, '%Y-%m-%d')
)

m.by.m <- data %>% 
  group_by(sm.date) %>%
    summarise(mean=mean(sumagoles))

# crear la serie de tiempo
min(m.by.m$sm.date)
series <- ts(m.by.m$mean, start=c(2010, 6), end = c(2019, 10), deltat=1/10)

plot(series, main='Goles por mes', xlab='Temporalidad', ylab='Goles')