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

####Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019####

#Primero solo nos quedamos con el periodo que nos interesa 
#y quitamos los meses que no tienen registros en todos los años del periodo (junio y julio)
#Tambien quitamos los años que no tengan todos los meses (2010)
periodo <- subset(match.data, (Ym >= "2011-01" & Ym <= "2019-12"))
periodo <- subset(periodo, (mes!= "junio" & mes!="julio"))

##Ahora calculamos el promedio por mes por año del periodo que nos interesa
Ym.periodo <- periodo %>% group_by(Ym) %>% 
  summarise(avg_Ym = mean(sumagoles, na.rm=TRUE), n = n())
#Ordenamos el dataframe por fecha
Ym.periodo <- Ym.periodo[order(Ym.periodo$Ym), ]

#Creamos la serie de tiempo sólo para el periodo de tiempo con los mismos meses
(golesMensuales.ts <- ts(Ym.periodo$avg_Ym,start =c(2011), end = c(2019,10), frequency = 10,
                         names = c("ENERO")))
#Graficamos
#opcion1
ts.plot(golesMensuales.ts, 
     main = "Promedio de Goles por Mes", 
     xlab = "Tiempo",
     sub = "Enero de 2011 - Diciembre de 2019, exceptuando los meses de junio y julio")

#opcion2
autoplot(golesMensuales.ts,linetype = 'solid', colour = 'blue',
         main	= "Promedio de Goles por Mes",
         xlab = "Tiempo\n Enero de 2011 a Diciembre de 2019, exceptuando los meses de junio y julio",
         ylab = "Promedio de goles")
#opcion3
ts_info(golesMensuales.ts)
autoplot(stl(golesMensuales.ts, s.window = "periodic"), ts.colour="blue")
#Descomponemos la serie
(golesMensuales.decom.A <- decompose(golesMensuales.ts))
str(golesMensuales.decom.A)
#Juntamos la serie de tiempo mas su componente estacional para graficarlas juntas
df=cbind(golesMensuales.ts, golesMensuales.decom.A$seasonal)
ts_plot(df,
        title = "Promedio de Goles por Mes",
        Xtitle = "Tiempo\n Enero de 2011 a Diciembre de 2019, exceptuando los meses de junio y julio",
        Ytitle = "Promedio de goles",
        line.mode =  "lines+markers",
        Xgrid = TRUE,
        Ygrid = TRUE,
        type = "multiple")