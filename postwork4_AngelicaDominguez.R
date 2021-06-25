#Importar y leer el archivo resultado del postwork 2; datos de la liga española de futbol
Fut.ligaEsp <- read.csv("Fut.ligaEsp.Postwork2.csv")
View(Fut.ligaEsp)
dim(Fut.ligaEsp)
#Encontrar la probabilidad marginal de que la casa anote "x" goles a partir de las frec. relativas
Frec.abs.FTH <- table(Fut.ligaEsp$FTHG) #Frecuencias absolutas
(pmarg.golesCasa <- c(prop.table(Frec.abs.FTHG))) #Probabilidades marginales

#Encontrar la probabilidad marginal de que el visitante anote "y" goles a partir de las frec. relativas
Frec.abs.FTAG <- table(Fut.ligaEsp$FTAG) #Frecuencias absolutas
(pmarg.golesVisitante <- c(prop.table(Frec.abs.FTAG))) #Probabilidades marginales

#Encontrar probabilidad conjunta de que la casa anote "x" goles y el visitante "y" goles
Frec.abs.ambos <- table(Fut.ligaEsp$FTHG, Fut.ligaEsp$FTAG)
(prob.conjunta <- prop.table(Frec.abs.ambos)) #Probabilidades conjunta

#######Obter una tabla de cocientes#######
#Dividimos las probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
#Calculamos el producto de probabilidades marginales
produto.pmarginales <- pmarg.golesCasa%*%t(pmarg.golesVisitante)
produto.pmarginales
#Calculamos el cociente de la probabilidad conjunta sobre el producto de probabilidades marginales
(cociente <- prob.conjunta/produto.pmarginales)
dim(cociente)


#######Hacemos un bootstrap para generar datos######## 
#Usamos replace para que se permitan valores repetidos
set.seed(52)
(bootstrap <- replicate(n=10, sample(cociente, replace = TRUE)))
dim(bootstrap)


#######Sacamos la media y la varianza para cada uno de los 63 cocientes########
(medias <- apply(bootstrap, MARGIN = 1, FUN = mean))
(varianzas <- apply(bootstrap, MARGIN = 1, FUN = var))
#Y los convertimos a formato matriz
(medias <- matrix(medias, nrow = 9, ncol = 7))
(varianzas <- matrix(varianzas, nrow = 9, ncol = 7))


#######Calculo estadístico de prueba para una muestra grande.########
#H0: Mu=1
#Ha: Mu!=1
#Calculamos el estadistico de prueba para los valores de los cocientes
#Usamos la varianza obtenida a partir de bootstrap
(z0 <- (cociente-1)/sqrt(varianzas/63))
#Y para comparar, calculamos tambien el estadistico de prueba es uno para cada uno de los 63 cocientes del bootstrap.
(z0b <- (medias-1)/sqrt(varianzas/63))


#######Encontrar region de rechazo para dos colas porque la hipotesis alternativa es Mu!=1##########
#Queremos que alfa=0.1. Dividimos alfa/2=0.05. Sacamos z05 para ambas colas
(z.05.arriba <- qnorm(p = 0.05, lower.tail = FALSE)) #z0 tiene que ser mas alta que z.05.arriba 
(z.05.abajo <- qnorm(p = 0.05, lower.tail = TRUE)) #z0 tiene que ser mas baja que z.05.abajo


#######Comprobar o rechazar hipotesis nula de que los valores de los cocientes son iguales a 1##########
#Region de rechazo de hipotesis nula Z0 > z.05.arriba o Z0 < z.05.abajo
(rechazo.cociente <- (z0 > z.05.arriba) | (z0 < z.05.abajo)) #Los valores de la primer tabal cocientes tiene que ser mas baja que z.05.abajo 
                                    #o mas grandes que z.05.arriba 
(rechazo.samples <- (z0b > z.05.arriba) | (z0b < z.05.abajo)) #Comparamos con las medias del bootstrap

#Los valores TRUE nos indican en que casos se rechaza la hipotesis nula, es decir que
#existe una dependencia entre las variables "x" y "y"

#Los valores FALSE nos indican en que casos que no se rechaza H0, es decir que
#las variables "x" y "y" son independientes
