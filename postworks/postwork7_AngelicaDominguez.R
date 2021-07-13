library(mongolite)

m <-mongo(
    collection = "match",
    db = "match_games",
    url = "mongodb+srv://introabd:facil001@cluster0.blz9f.mongodb.net/testt",
    verbose = FALSE,
    options = ssl_options()
  )

mydata <- m$find()
num.registros = m$count()

print(paste("El número total de registros en la colección match es",num.registros))

consulta = m$find('{"date":"2015-12-20", "home.team":"Real Madrid"}')
diferencia=as.numeric(consulta$home$score)-as.numeric(consulta$away$score)

print(paste("El equipo Real Madrid goleó a su contrincante",consulta$away$team,
            "con una diferencia de",diferencia,"goles"))

m$disconnect()
