readRenviron('~/.Renviron')
source(paste(Sys.getenv('BEDU_PATH'), 'scripts/utils.R', sep=''))

# 1) -->
# Recuperar el dataframe
SmallData <- urls_to_df(c(
  'https://www.football-data.co.uk/mmz4281/1718/SP1.csv',
  'https://www.football-data.co.uk/mmz4281/1819/SP1.csv',
  'https://www.football-data.co.uk/mmz4281/1920/SP1.csv'
), c('Date', 'HomeTeam', 'FTHG', 'AwayTeam', 'FTAG'))

# Cambiar los nombres de las columnas
SmallData <- rename(
  SmallData, 
  date=Date, 
  home.team=HomeTeam, 
  home.score=casa, 
  away.team=AwayTeam, 
  away.score=visitante
)

# Guardar el DF en un CSV
write.csv(SmallData, 'soccer.csv', row.names = F)

# 2) -->
# install.packages('fbRanks')
library(fbRanks)

listasoccer <- create.fbRanks.dataframes('soccer.csv')
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

# 3) -->
fechas <- unique(anotaciones$date)
n <- length(fechas)

ranking <- rank.teams(anotaciones, equipos,
                      max.date = 
                        max(fechas[fechas!=max(fechas)]),
                      min.date = min(fechas))

# 4) -->
predict(ranking, date=max(fechas))