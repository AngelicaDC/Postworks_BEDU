#Postwork sesion1
#Importamos el data set de la liga de futbol espanola 2019-2020 usando la funcion read.csv() desde el URL.
LigaEsp2019.2020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#Goles anotados por los equipos que jugaron en casa (FTHG) y los visitantes (FTAG)
goles.casa <- c(LigaEsp2019.2020$FTHG)
goles.visitante <- c(LigaEsp2019.2020$FTAG)
 
#Tablas de frecuencia absoluta de goles de la casa, goles de visitantes y casa vs visitantes
frec.goles.casa <- table(goles.casa)
frec.goles.visitante <- table(goles.visitante)
frec.goles <- table(goles.casa, goles.visitante)

#Tablas de frecuencia relativa de goles de la casa y goles de visitantes
frec.rel.goles.casa <- c(prop.table(x=frec.goles.casa))
frec.rel.goles.visitante <-prop.table(x=frec.goles.visitante)

goles <- c(seq(0,6,1))
for (i in 1:length(frec.rel.goles.casa)) {
  print(paste("La probabilidad marginal de que la casa anote",i,"goles es: ", frec.rel.goles.casa[i]))
}

for (i in 1:length(frec.rel.goles.visitante)) {
  print(paste("La probabilidad marginal de que el vistitante anote",i,"goles es: ", frec.rel.goles.visitante[i]))
}

#Tabla de probabilidad conjunto de "x" goles del equipo de casa vs "y" goles del visitante
print("La probabilidad conjunta de que el equipo de casa anote 'x' goles y el equivo visitante anote 'y' goles 
      está representada en la tabla:")
(frec.rel.goles <- prop.table(frec.goles))
