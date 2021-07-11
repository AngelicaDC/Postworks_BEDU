library(fbRanks)
library(dplyr)
setwd("C:/Users/Ok/Documents/BEDU/R/postworks/") #cambiar ubicación

#Creamos una lista con las direcciones donde se encuentran los archivos de futbol
#de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera divisiÃ³n de la liga espaÃ±ola
l.URLs <- list("https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
               "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
               "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
               )

#Leemos los archivos desde las URLs y los guardamos como elementos DataFrame en una lista
lista_archivos <- lapply(l.URLs, read.csv)

#Creo una lista con las columnas seleccionadas de cada dataframe
lista_columnas <- lapply(lista_archivos, select, c("Date","HomeTeam","FTHG","AwayTeam","FTAG"))

#La columa "Date" de los dataframes es de clase caracter. Debemos de cambiarla a clase Date para poder trabajar.
#El formato es diferente para cada dataframe
tmp2017.2018.dfcols <- mutate(data.frame(lista_columnas[1]), Date = as.Date(Date, "%d/%m/%y"))
tmp2018.2019.dfcols <- mutate(data.frame(lista_columnas[2]), Date = as.Date(Date, "%d/%m/%Y"))
tmp2019.2020.dfcols <- mutate(data.frame(lista_columnas[3]), Date = as.Date(Date, "%d/%m/%Y"))

#Creamos un solo dataframe que contenga la informacion de las tres temporadas y lo guardamos
lista_final <- list(tmp2017.2018.dfcols,tmp2018.2019.dfcols,tmp2019.2020.dfcols)
SmallData <- do.call(rbind, lista_final)
SmallData <- rename(SmallData, date=Date, home.team=HomeTeam, home.score=FTHG, away.team=AwayTeam, away.score=FTAG)
write.csv(SmallData, file = "soccer.csv", row.names = FALSE)

#Importamos el "archivo soccer.csv" como un lista con dataframes a través de la función create.fbRanks.dataframes.
#Le damos el formato de fecha
listasoccer <- create.fbRanks.dataframes("soccer.csv", date.format="%Y-%m-%d", na.remove = FALSE)

#Guardamos los dataframes de la lista en dataframes independientes
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

#Extraer los valores únicos de fechas. 
#Usando str(anotaciones) nos damos cuenta que date está guardada como una columna de anotaciones
fecha <- c(unique(anotaciones$date))
n <- length(fecha)

#Con la función rank.teams creamos un ranking de los equipos de acuerdo a su desempeño (anotaciones)
#La función rank.teams ajusta un modelo linear que estima la fuerza de ataque y defensa de los equipos
ranking <- rank.teams(scores=anotaciones, teams=equipos, max.date=max(fecha), min.date=min(fecha), date.format="%Y-%m-%d")

#Estimar las probabilidades de los eventos que el equipo de casa gane, que el equipo vistante gane o que sea un empate
#para la última fecha del vector fecha.
prediccion = predict(ranking, date = fecha[n], max.date=max(fecha), min.date=min(fecha))

#Diez partidos se jugaron en la última fecha. 
df.pred.vs.real = data.frame(fecha=prediccion$scores$date, pred.HW=prediccion$scores$home.win, pred.AW=prediccion$scores$away.win, pred.Empate=prediccion$scores$tie,
                             Real.HomeScore=prediccion$scores$home.score, Real.AwayScore=prediccion$scores$away.score,
                             select(filter(anotaciones, anotaciones$date==fecha[n]), home.team, away.team))
df.pred.vs.real
#De los diez partidos que se jugaron en la última fecha, el equipo de casa ganó en cinco ocasiones.
#Contra los pronósticos de probabilidades: 
#     1. El Valldolid (casa) le ganó al Betis (visitante); 
#     2. Ath Madrid (casa) y Sociedad (visitante) quedaron empates;
#     3. Leganes (casa) y Real Madrid (visitante) quedaron empates;




str(ranking)
str(prediccion)

#Hacer prueba de hipotesis de si la probabilidad de que un equipo gane es la misma que la del otro.
#Buscar si hay valores nulos "Missing scores must be denoted NaN."
#The function uses Dixon and Coles time-weighted poisson model to estimate attack and defense strengths using the glm function.
