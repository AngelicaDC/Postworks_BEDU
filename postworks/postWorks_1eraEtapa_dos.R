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
frec.rel.goles.casa <- prop.table(x=frec.goles.casa)
frec.rel.goles.visitante <- prop.table(x=frec.goles.visitante)

goles <- c(seq(0,6,1))
for (i in 1:length(frec.rel.goles.casa)) {
  print(paste("La probabilidad marginal de que la casa anote",i,"goles es: ", frec.rel.goles.casa[i]))
}

for (i in 1:length(frec.rel.goles.visitante)) {
  print(paste("La probabilidad marginal de que el vistitante anote",i,"goles es: ", frec.rel.goles.visitante[i]))
}

#Tabla de probabilidad conjunto de "x" goles del equipo de casa vs "y" goles del visitante
print("La probabilidad conjunta de que el equipo de casa anote 'x' goles y el equivo visitante anote 'y' goles está representada en la tabla:")
(frec.rel.goles <- prop.table(frec.goles))

#Postwork sesion 2
library(dplyr)
#setwd("C:/Users/Ok/Documents/BEDU/R/postworks/")
#Creamos una lista con las direcciones donde se encuentran los archivos de futbol
#de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera divisiÃ³n de la liga espaÃ±ola
l.URLs <- list("https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
               "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
               "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
)
#Leemos los archivos desde las URLs y los guardamos como elementos DataFrame en una lista
lista_archivos <- lapply(l.URLs, read.csv)
length(lista_archivos) #La lista contiene 3 elementos que son los 3 dataframes

#El elemento 1 de la lista contiene el dataframe con los datos de la temporada 2017-2018
str(data.frame(lista_archivos[1]))
head(data.frame(lista_archivos[1]))
View(data.frame(lista_archivos[1]))
summary(data.frame(lista_archivos[1]))

#El elemento 2 de la lista contiene el dataframe con los datos de la temporada 2018-2019
str(data.frame(lista_archivos[2]))
head(data.frame(lista_archivos[2]))
View(data.frame(lista_archivos[2]))
summary(data.frame(lista_archivos[2]))

#El elemento 3 de la lista contiene el dataframe con los datos de la temporada 2019-2020
str(data.frame(lista_archivos[3]))
head(data.frame(lista_archivos[3]))
View(data.frame(lista_archivos[3]))
summary(data.frame(lista_archivos[3]))

#Creo una lista con las columnas seleccionadas de cada dataframe
lista_columnas <- lapply(lista_archivos, select, c("Date", "HomeTeam", "AwayTeam", "FTHG", "FTAG", "FTR"))
length(lista_columnas) #La lista contiene 3 elementos que son un dataframe de las columnas seleccionadas por cada temporada
str(data.frame(lista_columnas[1]))
str(data.frame(lista_columnas[2]))
str(data.frame(lista_columnas[3]))
  
#La columa "Date" de los dataframes es de clase caracter. Debemos de cambiarla a clase Date
#El formato es diferente para cada dataframe
tmp2017.2018.dfcols <- mutate(data.frame(lista_columnas[1]), Date = as.Date(Date, "%d/%m/%y"))
tmp2018.2019.dfcols <- mutate(data.frame(lista_columnas[2]), Date = as.Date(Date, "%d/%m/%Y"))
tmp2019.2020.dfcols <- mutate(data.frame(lista_columnas[3]), Date = as.Date(Date, "%d/%m/%Y"))

#Ahora comprobamos que la columna "Date" sea clase Date.
class(tmp2017.2018.dfcols$Date)
class(tmp2018.2019.dfcols$Date)
class(tmp2019.2020.dfcols$Date)

#Por ultimo unimos todos los dataframes en uno solo
lista_final <- list(tmp2017.2018.dfcols,tmp2018.2019.dfcols,tmp2019.2020.dfcols)
df.todo.final <- do.call(rbind, lista_final)
str(df.todo.final)

#Guardamos el dataframe final para usarlo en la sesion 3
##write.csv(df.todo.final, file = "Fut.ligaEsp.Postwork2.csv", sep = ",", col.names=TRUE, row.names = FALSE)

library(ggplot2)

#Importar y leer el archivo resultado del postwork 2; datos de la liga espaÃ±ola de futbol
Fut.ligaEsp <- read.csv("https://raw.githubusercontent.com/AngelicaDC/Postworks_BEDU/main/data/Fut.ligaEsp.Postwork2.csv")
str(Fut.ligaEsp)

#Goles anotados por los equipos que jugaron en casa (FTHG) y los visitantes (FTAG)
#Encontrar la probabilidad marginal de que la casa anote "x" goles a partir de las frec. relativas
Frec.abs.FTHG <- table(Fut.ligaEsp$FTHG) #Frecuencias absolutas
pmarg.golesCasa <- prop.table(Frec.abs.FTHG) #Probabilidades marginales

#Encontrar la probabilidad marginal de que el visitante anote "y" goles a partir de las frec. relativas
Frec.abs.FTAG <- table(Fut.ligaEsp$FTAG) #Frecuencias absolutas
pmarg.golesVisitante <- prop.table(Frec.abs.FTAG) #Probabilidades marginales

#Encontrar probabilidad conjunta de que la casa anote "x" goles y el visitante "y" goles
Frec.abs.ambos <- table(Fut.ligaEsp$FTHG, Fut.ligaEsp$FTAG)
prob.conjunta <- prop.table(Frec.abs.ambos) #Probabilidades conjunta

#Crear dataframes de probablidades para poder usar ggplot
#Casa
df.goles.casa <- data.frame(pmarg.golesCasa)
equipo <- rep(x = "casa", 9)
df.goles.casa <- cbind(df.goles.casa, equipo)
#Visita
df.goles.visitante <- data.frame(pmarg.golesVisitante)
equipo <- rep(x = "visitante", 7)
df.goles.visitante <- cbind(df.goles.visitante, equipo)
#Conjunta
df.prob.conjunta <- data.frame(prob.conjunta)
df.prob.conjunta <- rename(df.prob.conjunta, Goles_casa=Var1, Goles_visitante=Var2)

#Unir dataframes para hacer un grafico de barras que represente a ambos equipos
df.goles.ambos <- rbind(df.goles.casa, df.goles.visitante)
sort(df.goles.ambos$Freq)

#Graficar las probabilidades marginales de cada equipo

df.goles.ambos %>%
  ggplot() + 
  aes(x=Var1, y=Freq, fill = equipo) +
  geom_bar(stat="identity", position="dodge", color= "black") +
  ggtitle("Probabilidad de anotar goles") +
  ylab("Probabilidad marginal") +
  xlab("Numero de goles") +
  facet_wrap("equipo") +
  scale_fill_manual(name="Equipo", values=c("#0a7c93","#43cc68")) +
  theme(plot.background = element_rect (fill = 'linen'),
        panel.background = element_rect (fill = 'tan'), 
        panel.grid.minor = element_line(linetype = "dotted"),
        axis.text.x = element_text(face = "bold", color="black" , size = 10, hjust = 1), 
        axis.text.y = element_text(face = "bold", color="black" , size = 10, hjust = 1),
        legend.background = element_rect (fill = 'linen'),
        plot.title =element_text(face = "bold", color="black"))

#Graficar la probabilidad conjunta
df.prob.conjunta %>%
  ggplot() + 
  aes(x = Goles_casa, y = Goles_visitante, fill = Freq) + 
  geom_tile()+
  ggtitle("Probabilidad conjunta de goles anotados \n Casa vs Visitante") +
  scale_fill_gradient(low = "white", high = "green4", name="Probabilidad \n conjunta") +
  xlab("Goles de casa") +
  ylab("Goles de visitante") +
  theme_dark() +
  theme(plot.title =element_text(face = "bold", color="black", hjust = 0.5),
        axis.text.x = element_text(face = "bold", color="black" , size = 10, hjust = 1), 
        axis.text.y = element_text(face = "bold", color="black" , size = 10, hjust = 1),
        axis.title.x = element_text(face = "bold", color="black" , size = 12, hjust = 0.5),
        axis.title.y = element_text(face = "bold", color="black" , size = 12, hjust = 0.5),
        legend.title = element_text(face = "bold", color="black" , size = 10, hjust = 0.5)) +
  scale_fill_gradient2(guide = FALSE) +
  geom_text(aes(label = paste(round(Freq*100,1), "%")))

#Fin del postwork 3
#Importar y leer el archivo resultado del postwork 2; datos de la liga espaÃ±ola de futbol
Fut.ligaEsp <- read.csv("https://raw.githubusercontent.com/AngelicaDC/Postworks_BEDU/main/data/Fut.ligaEsp.Postwork2.csv")
View(Fut.ligaEsp)
dim(Fut.ligaEsp)
#Encontrar la probabilidad marginal de que la casa anote "x" goles a partir de las frec. relativas
(Frec.abs.FTH <- table(Fut.ligaEsp$FTHG)) #Frecuencias absolutas
(pmarg.golesCasa <- c(prop.table(Frec.abs.FTHG))) #Probabilidades marginales

#Encontrar la probabilidad marginal de que el visitante anote "y" goles a partir de las frec. relativas
Frec.abs.FTAG <- table(Fut.ligaEsp$FTAG) #Frecuencias absolutas
(pmarg.golesVisitante <- c(prop.table(Frec.abs.FTAG))) #Probabilidades marginales

#Encontrar probabilidad conjunta de que la casa anote "x" goles y el visitante "y" goles
(Frec.abs.ambos <- table(Fut.ligaEsp$FTHG, Fut.ligaEsp$FTAG))
(prob.conjunta <- prop.table(Frec.abs.ambos)) #Probabilidades conjunta

#######Obter una tabla de cocientes#######
#Dividimos las probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
#Calculamos el producto de probabilidades marginales
produto.pmarginales <- pmarg.golesCasa%*%t(pmarg.golesVisitante)
produto.pmarginales
#Calculamos el cociente de la probabilidad conjunta sobre el producto de probabilidades marginales
(cociente <- prob.conjunta/produto.pmarginales)
dim(cociente)



#######################################################################################################################
#Generaci?n de boostrap sobre los datos
#######Hacemos un bootstrap para generar datos######## 
#Usamos replace para que se permitan valores repetidoss
df_hv= paste(Fut.ligaEsp$FTHG, Fut.ligaEsp$FTAG)
class(df_hv)
df_hv
#Generamos s1000 muestras
bhv = replicate(n=1000, sample(df_hv, replace = TRUE))
#bhv

reformat <- function(s) {
  unlist(lapply(strsplit(s, ' '), strtoi))
}

ref=apply(bhv, 1, reformat)

View(ref)
class(bhv)
dim(ref)

nones <- seq(1,dim(ref)[1],2)
pares <- seq(2,dim(ref)[1],2)

casa <- as.matrix(ref[nones,])
casa <- t(casa)

visita <- as.matrix(ref[pares,])
visita <- t(visita)
dim(visita)

cocientes.list <-  list()
for (i in 1:dim(visita)[2]) {
  dfi <- cbind(casa[,i],visita[,i])
  #Sacamos frecuencias absolutas y probabilidades marginales
  fabsH=table(casa[,i])
  pmargH <- c(prop.table(fabsH))
  fabsV <- table(visita[,i])
  pmargV <- c(prop.table(fabsV))
  #Sacamos la probabilidad conjunta
  fabsCon <- table(dfi[,1],dfi[,2])
  pCon <- prop.table(fabsCon)
  prod.marg <- pmargH%*%t(pmargV)
  cociente.sample <- pCon/prod.marg
  cocientes.list[[i]] <- cociente.sample
}

dataFrames <- lapply(cocientes.list, as.data.frame)

SuperDataFrame <- Reduce(function(x, y) merge(x, y, by=c("Var1","Var2"),all=TRUE), dataFrames)
#SuperDataFrame
#str(SuperDataFrame)

SuperDataFrame$Medias <- rowMeans(SuperDataFrame[,3:1002],na.rm=TRUE)
SuperDataFrame$sd<- apply(SuperDataFrame[,3:1002], 1, sd,na.rm=TRUE)
SuperDataFrame$varianza <- SuperDataFrame$sd**2

chiquito <- select(SuperDataFrame,c("Var1","Var2","Medias","varianza"))

#####################################################################################################################

#######Sacamos la media y la varianza para cada uno de los 63 cocientes########
medias <- chiquito$Medias
varianzas <- chiquito$varianza
###################
#######Calculo estadistico de prueba para una muestra grande.########
#H0: Mu=1
#Ha: Mu!=1
#Calculamos el estadistico de prueba para los valores de los cocientes
#Usamos la varianza obtenida a partir de bootstrap
(z0 <- (cociente-1)/sqrt(varianzas/63))
#Y para comparar, calculamos tambien el estadistico de prueba es uno para cada uno de los 63 cocientes del bootstrap.
(z0b <- (medias-1)/sqrt(varianzas/63))
#Reorganizamos z0b
z0b <- t(matrix(z0b, nrow = 7, ncol = 9))

#######Encontrar region de rechazo para dos colas porque la hipotesis alternativa es Mu!=1##########
#Queremos que alfa=0.1. Dividimos alfa/2=0.05. Sacamos z05 para ambas colas
(z.025.arriba <- qnorm(p = 0.025, lower.tail = FALSE)) #z0 tiene que ser mas alta que z.05.arriba 
(z.025.abajo <- qnorm(p = 0.025, lower.tail = TRUE)) #z0 tiene que ser mas baja que z.05.abajo


#######Comprobar o rechazar hipotesis nula de que los valores de los cocientes son iguales a 1##########
#Region de rechazo de hipotesis nula Z0 > z.05.arriba o Z0 < z.05.abajo
(rechazo.cociente <- (z0 > z.025.arriba) | (z0 < z.025.abajo)) #Los valores de la primer tabal cocientes tiene que ser mas baja que z.05.abajo 
#o mas grandes que z.05.arriba 
(rechazo.samples <- (z0b > z.025.arriba) | (z0b < z.025.abajo)) #Comparamos con las medias del bootstrap

#Los valores TRUE nos indican en que casos se rechaza la hipotesis nula, es decir que
#existe una dependencia entre las variables "x" y "y"

#Los valores FALSE nos indican en que casos que no se rechaza H0, es decir que
#las variables "x" y "y" son independientes

################################################################################################################################
#PostWork 5
library(fbRanks)
library(dplyr)
#setwd("C:/Users/Ok/Documents/BEDU/R/postworks/") #cambiar ubicación

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
listasoccer <- create.fbRanks.dataframes("https://raw.githubusercontent.com/AngelicaDC/Postworks_BEDU/main/data/soccer.csv", date.format="%Y-%m-%d", na.remove = FALSE)

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
prediccion <-  predict(ranking, date = fecha[n], max.date=max(fecha), min.date=min(fecha))

#Diez partidos se jugaron en la última fecha. 
df.pred.vs.real <-  data.frame(fecha=prediccion$scores$date, pred.HW=prediccion$scores$home.win, pred.AW=prediccion$scores$away.win, pred.Empate=prediccion$scores$tie,
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

###############################################################################################################################
#PostWork6

library(dplyr)
library(lubridate)
library(ggplot2)
library(ggfortify)
#install.packages("ggfortify")
library(forecast)
library(TSstudio)
#install.packages("TSstudio")
library(plotly)


match.data <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2021/main/Sesion-06/Postwork/match.data.csv", sep=",")
match.data <- data.frame(match.data, sumagoles=c(match.data$home.score+match.data$away.score))

#Fijamos el formato de "date" y agregamos columna que indica mes y otra que indica mes y año
match.data <- match.data %>% mutate(date = as.Date(date, "%Y-%m-%d"), 
                                    mes=months(date),
                                    Ym = format(date, "%Y-%m"))

#Agrupamos por mes y sacamos el promedio de los goles
#Con n() podemos sacar el número de partidos de cada mes
MES <- match.data %>% group_by(mes) %>% 
  summarise(avg_mes = mean(sumagoles, na.rm=TRUE), n = n())
View(MES)
####Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019####

#Primero solo nos quedamos con el periodo que nos interesa 
#y quitamos los meses que no tienen registros en todos los años del periodo (junio y julio)
#Tambien quitamos los años que no tengan todos los meses (2010)
periodo <- subset(match.data, (Ym >= "2010-08" & Ym <= "2019-05"))
periodo <- subset(periodo, (mes!= "junio" & mes!="julio"))

##Ahora calculamos el promedio por mes por año del periodo que nos interesa
Ym.periodo <- periodo %>% group_by(Ym) %>% 
  summarise(avg_Ym = mean(sumagoles, na.rm=TRUE), n = n())
#Ordenamos el dataframe por fecha
Ym.periodo <- Ym.periodo[order(Ym.periodo$Ym), ]

#Creamos la serie de tiempo sólo para el periodo de tiempo con los mismos meses
#Se inicia en Agosto del 2010 y termina en mayo de 2019 para tener temporadas completas
(golesMensuales.ts <- ts(Ym.periodo$avg_Ym,start =c(2010,8), end = c(2019,05), frequency = 10))


#Graficamos la seri de tiempo
ts_info(golesMensuales.ts)
autoplot(stl(golesMensuales.ts, s.window = "periodic"), ts.colour="blue")
#Descomponemos la serie
(golesMensuales.decom.A <- decompose(golesMensuales.ts))
str(golesMensuales.decom.A)
#Juntamos la serie de tiempo mas su componente estacional para graficarlas juntas
df=cbind(Goles_Mes=golesMensuales.ts, Comp_Estacional=golesMensuales.decom.A$seasonal)
ts_plot(df,
        title = "Promedio de Goles por Mes",
        Xtitle = "Tiempo\n Agosto de 2010 a Mayo de 2019,\n exceptuando los meses de junio y julio",
        Ytitle = NULL,
        line.mode =  "lines+markers",
        Xgrid = TRUE,
        Ygrid = TRUE,
        type = "multiple")

#######################################################################
#PostWork7


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














