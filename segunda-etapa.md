# Segunda Etapa

A continuacion se muestra el procedimiento utilizado para cumplir con todos los puntos planteados dentro de los postworks de la 5ta a la 8va sesión.

## Postwork 5
```R
library(fbRanks)
library(dplyr)
setwd("C:/Users/Ok/Documents/BEDU/R/postworks/") #cambiar ubicación
```

Creamos una lista con las direcciones donde se encuentran los archivos de futbol de las temporadas `2017/2018`, `2018/2019` y `2019/2020` de la primera división de la liga española.

```R
l.URLs <- list("https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
               "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
               "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
               )
```

Leemos los archivos desde las URLs y los guardamos como elementos `DataFrame` en una lista.

```R
lista_archivos <- lapply(l.URLs, read.csv)

#Creo una lista con las columnas seleccionadas de cada dataframe
lista_columnas <- lapply(lista_archivos, select, c("Date","HomeTeam","FTHG","AwayTeam","FTAG"))
```

La columa `Date` de los dataframes es de clase caracter. Por lo tanto se procedio a cambiar a clase `Date` para poder trabajar.

```R
#El formato es diferente para cada dataframe
tmp2017.2018.dfcols <- mutate(data.frame(lista_columnas[1]), Date = as.Date(Date, "%d/%m/%y"))
tmp2018.2019.dfcols <- mutate(data.frame(lista_columnas[2]), Date = as.Date(Date, "%d/%m/%Y"))
tmp2019.2020.dfcols <- mutate(data.frame(lista_columnas[3]), Date = as.Date(Date, "%d/%m/%Y"))
```

Creamos un solo dataframe que contenga la informacion de las tres temporadas y lo guardamos.

```R
lista_final <- list(
    tmp2017.2018.dfcols,
    tmp2018.2019.dfcols,
    tmp2019.2020.dfcols
)

SmallData <- do.call(rbind, lista_final)
SmallData <- rename(
    SmallData, 
    date=Date, 
    home.team=HomeTeam, 
    home.score=FTHG, 
    away.team=AwayTeam, 
    away.score=FTAG
)
write.csv(SmallData, file = "soccer.csv", row.names = FALSE)
```

Importamos el `archivo soccer.csv` como un lista con dataframes a través de la función `create.fbRanks.dataframes`.

```R
#Le damos el formato de fecha
listasoccer <- create.fbRanks.dataframes(
    "soccer.csv", 
    date.format="%Y-%m-%d", 
    na.remove = FALSE
)
```

Guardamos los dataframes de la lista en dataframes independientes
```R
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams
```
Extraemos los valores únicos de fechas.
Usando str(anotaciones) nos damos cuenta que date está guardada como una columna de anotaciones

```R
fecha <- c(unique(anotaciones$date))
n <- length(fecha)
```

Con la función `rank.teams` creamos un ranking de los equipos de acuerdo a su desempeño (anotaciones).

La función `rank.teams` ajusta un modelo linear que estima la fuerza de ataque y defensa de los equipos.

```R
ranking <- rank.teams(
    scores=anotaciones, 
    teams=equipos, 
    max.date=max(fecha), 
    min.date=min(fecha), 
    date.format="%Y-%m-%d")
```

Estimar las probabilidades de los eventos que el equipo de casa gane, que el equipo vistante gane o que sea un empate para la última fecha del vector fecha.

```R
prediccion = predict(
    ranking, 
    date = fecha[n], 
    max.date=max(fecha), 
    min.date=min(fecha)
)
```
```
Predicted Match Results for 2017-08-18 to 2020-07-19
Model based on data from 2017-08-18 to 2020-07-19
---------------------------------------------
2020-07-19 Alaves vs Barcelona, HW 8%, AW 77%, T 15%, pred score 0.7-2.5  actual: AW (0-5)
2020-07-19 Valladolid vs Betis, HW 30%, AW 42%, T 28%, pred score 1-1.2  actual: HW (2-0)
2020-07-19 Villarreal vs Eibar, HW 46%, AW 29%, T 25%, pred score 1.6-1.2  actual: HW (4-0)
2020-07-19 Ath Madrid vs Sociedad, HW 53%, AW 20%, T 27%, pred score 1.5-0.8  actual: T (1-1)
2020-07-19 Espanol vs Celta, HW 32%, AW 41%, T 27%, pred score 1.1-1.3  actual: T (0-0)
2020-07-19 Granada vs Ath Bilbao, HW 43%, AW 28%, T 29%, pred score 1.2-1  actual: HW (4-0)
2020-07-19 Leganes vs Real Madrid, HW 13%, AW 66%, T 21%, pred score 0.7-1.9  actual: T (2-2)
2020-07-19 Levante vs Getafe, HW 25%, AW 47%, T 28%, pred score 0.9-1.4  actual: HW (1-0)
2020-07-19 Osasuna vs Mallorca, HW 47%, AW 28%, T 25%, pred score 1.6-1.2  actual: T (2-2)
2020-07-19 Sevilla vs Valencia, HW 34%, AW 39%, T 27%, pred score 1.2-1.3  actual: HW (1-0)
```
```R
#Diez partidos se jugaron en la última fecha. 
df.pred.vs.real = data.frame(
    fecha=prediccion$scores$date, 
    pred.HW=prediccion$scores$home.win, 
    pred.AW=prediccion$scores$away.win, 
    pred.Empate=prediccion$scores$tie,
    Real.HomeScore=prediccion$scores$home.score, 
    Real.AwayScore=prediccion$scores$away.score,
    select(filter(
        anotaciones, 
        anotaciones$date==fecha[n]), 
        home.team, 
        away.team))

df.pred.vs.real
```

|fecha|    pred.HW|pred.AW|pred.Empate|Real.HomeScore| Real.AwayScore|  home.team|   away.team|
|-|-|-|-|-|-|-|-|
|2020-07-19|   8.552|  76.501|      14.947|              0|              5|     Alaves|   Barcelona|
|2020-07-19|  29.800|  41.778|      28.422|              2|              0| Valladolid|       Betis|
|2020-07-19|  46.224|  28.589|      25.187|              4|              0| Villarreal|       Eibar|
|2020-07-19|  53.794|  19.876|      26.330|              1|              1| Ath Madrid|    Sociedad|
|2020-07-19|  31.833|  41.039|      27.128|              0|              0|    Espanol|       Celta|
|2020-07-19|  43.032|  28.552|      28.416|              4|              0|    Granada|  Ath Bilbao|
|2020-07-19|  12.988|  66.034|      20.978|              2|              2|    Leganes| Real Madrid|
|2020-07-19|  25.493|  46.957|      27.550|              1|              0|    Levante|      Getafe|
|2020-07-19|  47.476|  27.966|      24.558|              2|              2|    Osasuna|    Mallorca|
|2020-07-19|  34.575|  38.845|      26.580|              1|              0|    Sevilla|    Valencia|

De los diez partidos que se jugaron en la última fecha, el equipo de casa ganó en cinco ocasiones.

### Contra los pronósticos de probabilidades: 
1. El Valldolid (casa) le ganó al Betis (visitante)
2. Ath Madrid (casa) y Sociedad (visitante) quedaron empates
3. Leganes (casa) y Real Madrid (visitante) quedaron empates

```R
str(ranking)
str(prediccion)
```
```
List of 8
 $ fit            :List of 1
  ..$ cluster.1:List of 30
  .. ..$ coefficients     : Named num [1:51] 0.0589 0.1343 0.4036 0.9308 0.3613 ...
  .. .. ..- attr(*, "names")= chr [1:51] "attackAlaves" "attackAth Bilbao" "attackAth Madrid" "attackBarcelona" ...
  .. ..$ residuals        : Named num [1:2280] 0.0603 -0.5303 0.4504 2.3139 -0.3108 ...
  .. .. ..- attr(*, "names")= chr [1:2280] "1" "2" "3" "4" ...
  .. ..$ fitted.values    : Named num [1:2280] 0.943 2.129 1.379 0.604 1.451 ...
  .. .. ..- attr(*, "names")= chr [1:2280] "1" "2" "3" "4" ...
  .. ..$ effects          : Named num [1:2280] -0.167 -1.109 -4.873 -14.968 -3.842 ...
  .. .. ..- attr(*, "names")= chr [1:2280] "attackAlaves" "attackAth Bilbao" "attackAth Madrid" "attackBarcelona" ...
  .. ..$ R                : num [1:51, 1:51] -10.6 0 0 0 0 ...
  ...
  .. ..$ weights          : Named num [1:2280] 0.943 2.129 1.379 0.604 1.451 ...
  .. .. ..- attr(*, "names")= chr [1:2280] "1" "2" "3" "4" ...
 $ scores         :'data.frame':	1140 obs. of  7 variables:
  ..$ date          : Date[1:1140], format: "2017-08-18" "2017-08-18" "2017-08-19" ...
  ..$ home.team     : chr [1:1140] "Leganes" "Valencia" "Celta" "Girona" ...
  ..$ home.score    : num [1:1140] 1 1 2 2 1 0 2 0 1 0 ...
  ..$ away.team     : chr [1:1140] "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
  ..$ away.score    : num [1:1140] 0 0 3 2 1 0 0 3 0 1 ...
  ..$ home.residuals: num [1:1140] 0.0568 -1.1292 0.621 1.3965 -0.451 ...
  ..$ away.residuals: num [1:1140] -0.963 -0.5386 1.2937 0.3915 0.0754 ...
 $ teams          :'data.frame':	26 obs. of  1 variable:
  ..$ name: chr [1:26] "Alaves" "Ath Bilbao" "Ath Madrid" "Barcelona" ...
 $ max.date       : Date[1:1], format: "2020-07-19"
 $ min.date       : Date[1:1], format: "2017-08-18"
 $ time.weight.eta: num 0
 $ date.format    : chr "%Y-%m-%d"
...
```
```
> str(prediccion)

List of 7
 $ scores        :'data.frame':	10 obs. of  18 variables:
  ..$ date           : Date[1:10], format: "2020-07-19" "2020-07-19" "2020-07-19" ...
  ..$ home.team      : chr [1:10] "Alaves" "Valladolid" "Villarreal" "Ath Madrid" ...
  ..$ home.score     : num [1:10] 0 2 4 1 0 4 2 1 2 1
  ..$ away.team      : chr [1:10] "Barcelona" "Betis" "Eibar" "Sociedad" ...
  ..$ away.score     : num [1:10] 5 0 0 1 0 0 2 0 2 0
  ..$ home.residuals : num [1:10] -0.728 0.995 2.438 -0.469 -1.132 ...
  ..$ away.residuals : num [1:10] 2.464 -1.248 -1.172 0.219 -1.325 ...
  ..$ pred.home.score: num [1:10] 0.728 1.005 1.562 1.469 1.132 ...
  ..$ pred.away.score: num [1:10] 2.536 1.248 1.172 0.781 1.325 ...
  ..$ home.attack    : num [1:10] 0.0589 -0.0941 0.4597 0.4036 0.0378 ...
  ..$ home.defend    : num [1:10] 0 -0.1398 -0.0317 -0.6956 -0.0591 ...
  ..$ away.attack    : num [1:10] 0.931 0.361 0.191 0.448 0.341 ...
  ..$ away.defend    : num [1:10] -0.3769 0.0986 -0.0134 -0.0192 0.0859 ...
  ..$ home.win       : num [1:10] 8.55 29.8 46.22 53.79 31.83 ...
  ..$ away.win       : num [1:10] 76.5 41.8 28.6 19.9 41 ...
  ..$ tie            : num [1:10] 14.9 28.4 25.2 26.3 27.1 ...
  ..$ home.shutout   : num [1:10] 48.3 36.5 20.8 22.8 32.5 ...
  ..$ away.shutout   : num [1:10] 7.98 28.86 30.97 45.72 26.65 ...
 $ home.score    : Named num [1:10] 0.728 1.005 1.562 1.469 1.132 ...
  ..- attr(*, "names")= chr [1:10] "Alaves" "Valladolid" "Villarreal" "Ath Madrid" ...
 $ away.score    : Named num [1:10] 2.536 1.248 1.172 0.781 1.325 ...
  ..- attr(*, "names")= chr [1:10] "Barcelona" "Betis" "Eibar" "Sociedad" ...
 $ home.goals.sum: num [1:2] 11.7 17
 $ home.goals    : int [1:10, 1:100000] 0 0 1 1 0 1 1 0 0 1 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:10] "Alaves" "Valladolid" "Villarreal" "Ath Madrid" ...
  .. ..$ : NULL
 $ away.goals.sum: num [1:2] 13.8 10
 $ away.goals    : int [1:10, 1:100000] 4 2 1 0 2 1 1 2 1 0 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:10] "Barcelona" "Betis" "Eibar" "Sociedad" ...
  .. ..$ : NULL
```

## PostWork 6

```R
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
```

Fijamos el formato de `date` y agregamos columna que indica mes y otra que indica mes y año.
```R
match.data <- match.data %>% mutate(date = as.Date(date, "%Y-%m-%d"), 
                                    mes=months(date),
                                    Ym = format(date, "%Y-%m"))
```
Agrupamos por mes y sacamos el promedio de los goles.
Con `n()` podemos sacar el número de partidos de cada mes.
```R
MES <- match.data %>% group_by(mes) %>% 
  summarise(avg_mes = mean(sumagoles, na.rm=TRUE), n = n())
View(MES)
```
|mes|       avg_mes|     n|
|-|-|-|
|April|        2.74|   476|
|August|       2.48|   194|
|December|     2.64|   334|
|February|     2.65|   417|
|January|      2.83|   416|
|July|         2.26|    57|
|June|         2.63|    63|
|March|        2.66|   399|
|May|          2.94|   307|
|November|     2.79|   346|
|October|      2.83|   372|
|September|    2.68|   419|

Creamos la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019

Primero solo nos quedamos con el periodo que nos interesa y quitamos los meses que no tienen registros en todos los años del periodo (junio y julio)
Tambien quitamos los años que no tengan todos los meses (2010)

```R
periodo <- subset(match.data, (Ym >= "2010-08" & Ym <= "2019-05"))
periodo <- subset(periodo, (mes!= "junio" & mes!="julio"))
```

Ahora calculamos el promedio por mes por año del periodo que nos interesa
```R
Ym.periodo <- periodo %>% group_by(Ym) %>% 
  summarise(avg_Ym = mean(sumagoles, na.rm=TRUE), n = n())
```

Ordenamos el dataframe por fecha
```R
Ym.periodo <- Ym.periodo[order(Ym.periodo$Ym), ]
```

Creamos la serie de tiempo sólo para el periodo de tiempo con los mismos meses.
Se inicia en Agosto del 2010 y termina en mayo de 2019 para tener temporadas completas

```R
(golesMensuales.ts <- ts(Ym.periodo$avg_Ym,start =c(2010,8), end = c(2019,05), frequency = 10))
```
```
Time Series:
Start = c(2010, 8) 
End = c(2019, 5) 
Frequency = 10 
 [1] 2.200000 2.425000 3.025641 2.902439 2.733333 3.000000 2.325000 2.400000 2.930233 2.957447
[11] 3.000000 2.525000 2.420000 2.833333 2.900000 2.550000 3.050000 2.981818 2.854545 2.700000
[21] 3.000000 2.871795 2.838710 2.829268 2.794872 3.025000 2.750000 2.657895 3.023810 2.725000
[31] 3.800000 2.920000 2.711111 2.850000 3.166667 3.125000 2.902439 2.500000 2.474576 2.769231
[41] 2.387097 2.400000 2.650000 2.903226 2.631579 2.400000 2.555556 2.780488 2.200000 2.633333
[51] 3.225000 1.750000 2.650000 3.055556 2.441176 2.435897 3.204082 2.714286 3.025000 2.727273
[61] 2.880000 2.850000 2.878049 3.384615 2.600000 2.862069 2.675000 2.880952 2.948718 2.985294
[71] 3.250000 2.300000 2.800000 2.914286 3.033333 2.128205 3.200000 2.604167 2.513514 2.296296
[81] 3.312500 2.260870 2.644444 2.375000 2.709677 2.526316 2.756098 2.300000
```

Graficamos la serie de tiempo
```R
ts_info(golesMensuales.ts)
autoplot(stl(golesMensuales.ts, s.window = "periodic"), ts.colour="blue")
```
<p align="center"><img src="img/pw7_serie.png" /></p>

```R
#Descomponemos la serie
(golesMensuales.decom.A <- decompose(golesMensuales.ts))
```
```
$x
Time Series:
Start = c(2010, 8) 
End = c(2019, 5) 
Frequency = 10 
 [1] 2.200000 2.425000 3.025641 2.902439 2.733333 3.000000 2.325000 2.400000
...
[81] 3.312500 2.260870 2.644444 2.375000 2.709677 2.526316 2.756098 2.300000

$seasonal
Time Series:
Start = c(2010, 8) 
End = c(2019, 5) 
Frequency = 10 
 [1]  0.34240116 -0.27944922 -0.06718738  0.17684590  0.01273685 -0.08336467
...
[85]  0.01273685 -0.08336467  0.05269610 -0.08670444

$trend
Time Series:
Start = c(2010, 8) 
End = c(2019, 5) 
Frequency = 10 
 [1]       NA       NA       NA       NA       NA 2.729909 2.774909 2.749627
...
[81] 2.624373 2.622083 2.584680       NA       NA       NA       NA       NA

$random
Time Series:
Start = c(2010, 8) 
End = c(2019, 5) 
Frequency = 10 
 [1]           NA           NA           NA           NA           NA
 [6]  0.353455397 -0.502605378 -0.262922780  0.239019418  0.279976429
...
[81]  0.345726004 -0.081764466  0.126952031           NA           NA
[86]           NA           NA           NA

$figure
 [1]  0.34240116 -0.27944922 -0.06718738  0.17684590  0.01273685 -0.08336467
 [7]  0.05269610 -0.08670444 -0.02467675 -0.04329756

$type
[1] "additive"

attr(,"class")
[1] "decomposed.ts"
```

```R
str(golesMensuales.decom.A)
```
```
List of 6
 $ x       : Time-Series [1:88] from 2011 to 2019: 2.2 2.42 3.03 2.9 2.73 ...
 $ seasonal: Time-Series [1:88] from 2011 to 2019: 0.3424 -0.2794 -0.0672 0.1768 0.0127 ...
 $ trend   : Time-Series [1:88] from 2011 to 2019: NA NA NA NA NA ...
 $ random  : Time-Series [1:88] from 2011 to 2019: NA NA NA NA NA ...
 $ figure  : num [1:10] 0.3424 -0.2794 -0.0672 0.1768 0.0127 ...
 $ type    : chr "additive"
 - attr(*, "class")= chr "decomposed.ts"
```

Juntamos la serie de tiempo mas su componente estacional para graficarlas juntas
```R
df=cbind(Goles_Mes=golesMensuales.ts, Comp_Estacional=golesMensuales.decom.A$seasonal)
ts_plot(df,
        title = "Promedio de Goles por Mes",
        Xtitle = "Tiempo\n Agosto de 2010 a Mayo de 2019,\n exceptuando los meses de junio y julio",
        Ytitle = NULL,
        line.mode =  "lines+markers",
        Xgrid = TRUE,
        Ygrid = TRUE,
        type = "multiple")
```
<p align="center"><img src="img/pw6_ts.png" /></p>

## Postwork 7

```R
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
```
> El número total de registros en la colección match es 3800

```R
consulta = m$find('{"date":"2015-12-20", "home.team":"Real Madrid"}')
diferencia=as.numeric(consulta$home$score)-as.numeric(consulta$away$score)
print(paste("El equipo Real Madrid goleó a su contrincante",consulta$away$team,
            "con una diferencia de",diferencia,"goles"))
```
> El equipo Real Madrid goleó a su contrincante Vallecano con una diferencia de 8 goles

```R
m$disconnect()
```

## Postwork 8

```R
library(shiny)
library(shinydashboard)

ui <- 
    fluidPage(
        dashboardPage(skin = "purple",
                      dashboardHeader(title = "PostWork 8"),
                      dashboardSidebar(
                          sidebarMenu(
                              menuItem("Grafica de Barras", tabName = "Barras", icon = icon("bar-chart-o")),
                              menuItem("Graficas de Postwork 3", tabName = "PW3", icon = icon("area-chart")),
                              menuItem("Match Data - DataTable", tabName = "data_table", icon = icon("table")),
                              menuItem("Factores de Ganancia", tabName = "Fact", icon = icon("line-chart"))
                          )
                      ),
                      dashboardBody(
                          # Aditivos :D
                          singleton(tags$head(tags$script(src='script.js'))),
                          singleton(tags$head(tags$link(rel="stylesheet", type = "text/css", href = "styles.css"))),
                          
                          tabItems(
                              # Graficas de Barras
                              tabItem(tabName = "Barras",
                                      fluidRow(
                                          box(width = NULL, height = NULL,
                                              titlePanel("Grafica de Barras de Goles en contra y a favor"), 
                                              selectInput("variable", "Seleccione el valor de X",
                                                          choices = c("home.score","away.score")),
                                              plotOutput("output_plot")
                                          )
                                      )
                              ),
                              
                              # Graficas obtenidas en PostWork3
                              tabItem(tabName = "PW3", 
                                      fluidRow(
                                          box(width = NULL, height = NULL,
                                              titlePanel(h3("Graficos obtenidos en Postwork 3")),
                                              img(src = "Barras.png", height = 450, width = 650),
                                              img(src =  "ProbConjunta.png", height = 450, width = 650)
                                          )
                                      )
                              ),
                              #Match Data en DataTable
                              tabItem(tabName = "data_table",
                                      fluidRow(
                                          box(width = NULL, height = NULL,
                                              titlePanel(h3("Match Data")),
                                              dataTableOutput ("dataTable")
                                          )
                                      )
                              ), 
                              #Factores de Ganacia Maximos y promedios Obtenidos en momios.r
                              tabItem(tabName = "Fact",
                                      fluidRow(
                                          box(width = NULL, height = NULL,
                                              titlePanel(h3("Factores de Ganancia")),
                                              h4("Factor de Ganancia Maximos:"),
                                              img(src = "Escenario_MomiosMax.png", height = 450, width = 750),
                                              h4("Factor de Ganancia Promedios:"),
                                              img(src = "Momios_Promedio.png", height = 450, width = 750)
                                          )
                                      )
                              )
                          )
                      )
        )
    )

server <- function(input, output) {
    library(ggplot2)
    
    data <- read.csv("https://raw.githubusercontent.com/AngelicaDC/Postworks_BEDU/main/postworks/postWork8%20-%20Ignacio/PostWork8/data/match.data.csv")
    
    output$output_plot <- renderPlot({
        ggplot(data, aes_string(x = input$variable, fill = "FTR")) +
            geom_bar() +
            facet_wrap(as.factor(data$away.team))+
            ggtitle("Goles a favor y en contra")+
            ylab("N° de Goles")}, width = "auto" ,height = 650)
    output$dataTable <- renderDataTable({data},options = list(aLengthMenu = c(10,20,50), iDisplayLength = 20))
}

shinyApp(ui, server)
```

El dashboard obtenido como resultado del codigo anterior se encuetra disponible en el [siguiente enlace](https://ignaciodiaz.shinyapps.io/PostWork8/).
<p align="center"><img src="img/Dashboard.png" /></p>

> _NOTA_: El código fuente que se muestra en este documento se encuentra [aquí](postWorks_1eraEtapa.R).

<p align="center"><img width="300" src="https://media.giphy.com/media/3oEdva9BUHPIs2SkGk/giphy.gif" /></p>
