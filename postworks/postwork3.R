#Postwork sesion 3
library(dplyr)
library(ggplot2)

#Importar y leer el archivo resultado del postwork 2; datos de la liga española de futbol
Fut.ligaEsp <- read.csv("Fut.ligaEsp.Postwork2.csv")
str(Fut.ligaEsp)

#Goles anotados por los equipos que jugaron en casa (FTHG) y los visitantes (FTAG)
#Encontrar la probabilidad marginal de que la casa anote "x" goles a partir de las frec. relativas
Frec.abs.FTH <- table(Fut.ligaEsp$FTHG) #Frecuencias absolutas
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
  geom_bar(stat="identity", position="dodge", color="red4") +
  ggtitle("Probabilidad de anotar goles") +
  ylab("Probabilidad marginal") +
  xlab("Número de goles") +
  facet_wrap("equipo") +
  scale_fill_manual(name="Equipo", values=c("red4","oldlace")) +
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
  ylab("Goles de casa") +
  xlab("Goles de visitante") +
  theme_dark() +
  theme(plot.title =element_text(face = "bold", color="black", hjust = 0.5),
        axis.text.x = element_text(face = "bold", color="black" , size = 10, hjust = 1), 
        axis.text.y = element_text(face = "bold", color="black" , size = 10, hjust = 1),
        axis.title.x = element_text(face = "bold", color="black" , size = 12, hjust = 0.5),
        axis.title.y = element_text(face = "bold", color="black" , size = 12, hjust = 0.5),
        legend.title = element_text(face = "bold", color="black" , size = 10, hjust = 0.5))

#Fin del postwork 3
        