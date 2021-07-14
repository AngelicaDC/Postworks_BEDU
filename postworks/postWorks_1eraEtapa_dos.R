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
print("La probabilidad conjunta de que el equipo de casa anote 'x' goles y el equivo visitante anote 'y' goles estÃ¡ representada en la tabla:")
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

library(dplyr)
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

df_hv= paste(Fut.ligaEsp$FTHG, Fut.ligaEsp$FTAG)
class(df_hv)
df_hv

bhv = replicate(n=1000, sample(df_hv, replace = TRUE))
bhv

reformat <- function(s) {
  unlist(lapply(strsplit(s, ' '), strtoi))
}

ref=apply(bhv, 1, reformat)

View(ref)
bhv[[11400]]

class(bhv)
dim(ref)

nones=seq(1,dim(ref)[1],2)
pares=seq(2,dim(ref)[1],2)

casa=as.matrix(ref[nones,])
casa=t(casa)

table(casa[,1])
visita=as.matrix(ref[pares,])
visita=t(visita)
dim(visita)

cocientes.list = list()
for (i in 1:dim(visita)[2]) {
  dfi=cbind(casa[,i],visita[,i])
  #Sacamos frecuencias absolutas y probabilidades marginales
  fabsH=table(casa[,i])
  pmargH=c(prop.table(fabsH))
  fabsV=table(visita[,i])
  pmargV=c(prop.table(fabsV))
  #Sacamos la probabilidad conjunta
  fabsCon=table(dfi[,1],dfi[,2])
  pCon=prop.table(fabsCon)
  prod.marg <- pmargH%*%t(pmargV)
  cociente.sample <- pCon/prod.marg
  cocientes.list[[i]]=cociente.sample
}

cocientes.list[[1]]

dataFrames <- lapply(cocientes.list, as.data.frame)
cocientes.list[[1]]
as.data.frame(cocientes.list[[1]])

SuperDataFrame <- Reduce(function(x, y) merge(x, y, by=c("Var1","Var2"),all=TRUE), dataFrames)
#SuperDataFrame
#str(SuperDataFrame)

SuperDataFrame$Medias <- rowMeans(SuperDataFrame[,3:1002],na.rm=TRUE)
SuperDataFrame$sd<- apply(SuperDataFrame[,3:1002], 1, sd,na.rm=TRUE)
SuperDataFrame$varianza <- SuperDataFrame$sd**2

#SuperDataFrame
library(dplyr)

chiquito <- select(SuperDataFrame,c("Var1","Var2","Medias","varianza"))
attach(publi)

#####################################################################################################################3
#######Hacemos un bootstrap para generar datos######## 
#Usamos replace para que se permitan valores repetidos
set.seed(52)
(bootstrap <- replicate(n=1000, sample(cociente, replace = TRUE)))

dim(bootstrap)
bv[1]
length(bv[[1]])


#######Sacamos la media y la varianza para cada uno de los 63 cocientes########
(medias <- apply(bootstrap, MARGIN = 1, FUN = mean))
(varianzas <- apply(bootstrap, MARGIN = 1, FUN = var))
#Y los convertimos a formato matriz
(medias <- matrix(medias, nrow = 9, ncol = 7))
(varianzas <- matrix(varianzas, nrow = 9, ncol = 7))

###################
medias <- chiquito$Medias
varianzas <- chiquito$varianza
#######Calculo estadistico de prueba para una muestra grande.########
#H0: Mu=1
#Ha: Mu!=1
#Calculamos el estadistico de prueba para los valores de los cocientes
#Usamos la varianza obtenida a partir de bootstrap
(z0 <- (cociente-1)/sqrt(varianzas/63))
#Y para comparar, calculamos tambien el estadistico de prueba es uno para cada uno de los 63 cocientes del bootstrap.
(z0b <- (medias-1)/sqrt(varianzas/63))
z0b
dim(z0)
dim(z0b)
z0b <- t(matrix(z0b, nrow = 7, ncol = 9))
z0b

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

