#Postwork sesion 2
library(dplyr)

#Creamos una lista con las direcciones donde se encuentran los archivos de futbol
#de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española
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
