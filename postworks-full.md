# Postworks Bedu - Data Science
A lo largo del curso estuvimos trabajando con datos de los partidos de la liga española de fútbol en diferentes temporadas. Estos datasets contienen información como la fecha en la que se jugaron los partidos, los equipos que jugaron de casa y visitante, así como El número  de goles anotados por el equipo de casa y el visitante en cada partido.

# Primera Etapa
A continuacion se muestra el procedimiento utilizado para cumplir con todos los puntos planteados dentro de los postworks.

## Postwork sesion 1
Aprendimos a usar la función `read.csv` para importar y leer un archivo separado por comas. Con ayuda de la función table encontramos las probabilidades marginales y conjuntas de que los equipos de casa y visitante anotarán un número determinado de goles.


Importamos el data set de la liga de futbol española 2019-2020 usando la funcion read.csv() desde el URL.
```R
LigaEsp2019.2020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
```

Los goles anotados por los equipos que jugaron en casa (FTHG) y los visitantes (FTAG)
```R
goles.casa <- c(LigaEsp2019.2020$FTHG)
goles.visitante <- c(LigaEsp2019.2020$FTAG)
```

Tablas de frecuencia absoluta de goles de la casa, goles de visitantes y casa vs visitantes
```R
frec.goles.casa <- table(goles.casa)
frec.goles.visitante <- table(goles.visitante)
frec.goles <- table(goles.casa, goles.visitante)
```

Tablas de frecuencia relativa de goles de la casa y goles de visitantes
```R
frec.rel.goles.casa <- prop.table(x=frec.goles.casa)
frec.rel.goles.visitante <- prop.table(x=frec.goles.visitante)
```
```R
goles <- c(seq(0,6,1))
for (i in 1:length(frec.rel.goles.casa)) {
    print(
        paste(
            "La probabilidad marginal de que la casa anote",
            i-1,"goles es: ", frec.rel.goles.casa[i]
        )
    )
}
```
> La probabilidad marginal de que la casa anote 0 goles es:  0.231578947368421
> 
> La probabilidad marginal de que la casa anote 1 goles es:  0.347368421052632
> 
> La probabilidad marginal de que la casa anote 2 goles es:  0.260526315789474
> 
> La probabilidad marginal de que la casa anote 3 goles es:  0.1
> 
> La probabilidad marginal de que la casa anote 4 goles es:  0.0368421052631579
> 
> La probabilidad marginal de que la casa anote 5 goles es:  0.0210526315789474
> 
> La probabilidad marginal de que la casa anote 6 goles es:  0.00263157894736842

```R
for (i in 1:length(frec.rel.goles.visitante)) {
  print(paste("La probabilidad marginal de que el vistitante anote",i,"goles es: ", frec.rel.goles.visitante[i]))
}
```
> La probabilidad marginal de que el vistitante anote 1 goles es:  0.357894736842105
> 
> La probabilidad marginal de que el vistitante anote 2 goles es:  0.352631578947368
> 
> La probabilidad marginal de que el vistitante anote 3 goles es:  0.213157894736842
> 
> La probabilidad marginal de que el vistitante anote 4 goles es:  0.0473684210526316
> 
> La probabilidad marginal de que el vistitante anote 5 goles es:  0.0236842105263158
> 
> La probabilidad marginal de que el vistitante anote 6 goles es:  0.00526315789473684

Tabla de probabilidad conjunto de `x` goles del equipo de casa vs `y` goles del visitante
```R
print("La probabilidad conjunta de que el equipo de casa anote 'x' goles y el equivo visitante anote 'y' goles estÃ¡ representada en la tabla:")
(frec.rel.goles <- prop.table(frec.goles))
```
> La probabilidad conjunta de que el equipo de casa anote 'x' goles y el equivo visitante anote 'y' goles estÃ¡ representada en la tabla:


||goles.visitante|||||||
|-|-|-|-|-|-|-|-|
|goles.casa||||||||
|||0|1|2|3|4|5|
||0|0.086842105|0.073684211|0.039473684|0.021052632|0.005263158|0.005263158|
||1|0.113157895|0.128947368|0.084210526|0.013157895|0.007894737|0.000000000|
||2|0.102631579|0.092105263|0.052631579|0.007894737|0.005263158|0.000000000|
||3|0.036842105|0.036842105|0.018421053|0.005263158|0.002631579|0.000000000|
||4|0.010526316|0.013157895|0.010526316|0.000000000|0.002631579|0.000000000|
||5|0.005263158|0.007894737|0.007894737|0.000000000|0.000000000|0.000000000|
||6|0.002631579|0.000000000|0.000000000|0.000000000|0.000000000|0.000000000|


## Postwork 2
Aprendimos a aplicar la función `lapply` junto con `read.csv` para importar archivos desde una lista con las URLs, leer estos archivos y almacenarlos como data frames dentro de una lista. Con Mutate y as.Date le dimos el formato correcto a la columna de fechas de los partidos. Por último, con `do.call` y `rbind` unimos todos los data frames en un solo, y a este último lo guardamos en un archivo separado por comas con la función `write.csv`.

Creamos una lista con las direcciones donde se encuentran los archivos de futbol de las temporadas `2017/2018`, `2018/2019` y `2019/2020` de la primera división de la liga española
```R
library(dplyr)
l.URLs <- list("https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
               "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
               "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
)
```

Leemos los archivos desde las URLs y los guardamos como elementos DataFrame en una lista
```R
lista_archivos <- lapply(l.URLs, read.csv)
length(lista_archivos)  #La lista contiene 3 elementos que son los 3 dataframes
```

El elemento 1 de la lista contiene el dataframe con los datos de la temporada 2017-2018
```R
str(data.frame(lista_archivos[1]))
head(data.frame(lista_archivos[1]))
View(data.frame(lista_archivos[1]))
summary(data.frame(lista_archivos[1]))
```
```
Div     Date   HomeTeam   AwayTeam FTHG FTAG FTR HTHG HTAG HTR HS AS HST AST HF AF HC AC
1 SP1 18/08/17    Leganes     Alaves    1    0   H    1    0   H 16  6   9   3 14 18  4  2
2 SP1 18/08/17   Valencia Las Palmas    1    0   H    1    0   H 22  5   6   4 25 13  5  2
3 SP1 19/08/17      Celta   Sociedad    2    3   A    1    1   D 16 13   5   6 12 11  5  4
4 SP1 19/08/17     Girona Ath Madrid    2    2   D    2    0   H 13  9   6   3 15 15  6  0
5 SP1 19/08/17    Sevilla    Espanol    1    1   D    1    1   D  9  9   4   6 14 12  7  3
6 SP1 20/08/17 Ath Bilbao     Getafe    0    0   D    0    0   D 12  8   2   2 16 15  7  6
  HY AY HR AR B365H B365D B365A  BWH  BWD  BWA  IWH IWD  IWA  LBH  LBD  LBA  PSH  PSD  PSA
1  0  1  0  0  2.05  3.20  4.10 2.05 3.10 4.10 2.10 3.4 3.50 2.05 3.00 4.20 2.03 3.25 4.52
2  3  3  0  1  1.75  3.80  4.50 1.75 3.90 4.60 1.75 3.6 4.80 1.75 3.80 4.33 1.78 4.01 4.83
3  3  1  0  0  2.38  3.25  3.20 2.40 3.30 3.00 2.50 3.3 2.85 2.35 3.25 3.00 2.44 3.40 3.16
4  2  4  0  1  8.00  4.33  1.45 7.50 4.33 1.45 7.20 4.4 1.45 7.50 4.00 1.50 8.36 4.38 1.49
5  2  4  1  0  1.62  4.00  5.50 1.62 3.90 5.75 1.55 4.0 6.20 1.60 3.90 5.50 1.62 4.17 6.18
6  1  3  0  1  1.50  4.00  7.50 1.48 4.25 7.00 1.50 4.2 6.50 1.50 4.00 7.00 1.53 4.37 7.31
   WHH  WHD  WHA  VCH VCD  VCA Bb1X2 BbMxH BbAvH BbMxD BbAvD BbMxA BbAvA BbOU BbMx.2.5
1 2.05 3.10 4.00 2.05 3.2 4.40    35  2.12  2.03  3.40  3.15  4.52  4.17   31     2.84
2 1.80 3.75 4.20 1.80 4.0 4.60    35  1.83  1.77  4.04  3.86  4.83  4.46   33     1.69
3 2.40 3.40 2.90 2.40 3.4 3.13    35  2.50  2.39  3.50  3.32  3.20  3.01   34     2.03
4 8.00 4.20 1.44 7.50 4.3 1.50    35  8.36  7.53  4.40  4.17  1.51  1.48   34     2.20
5 1.67 3.60 5.50 1.65 4.0 5.75    35  1.69  1.63  4.17  3.93  6.20  5.58   33     1.81
6 1.50 4.00 7.00 1.50 4.2 7.00    34  1.53  1.50  4.40  4.17  7.50  6.94   32     2.01
  BbAv.2.5 BbMx.2.5.1 BbAv.2.5.1 BbAH BbAHh BbMxAHH BbAvAHH BbMxAHA BbAvAHA PSCH PSCD PSCA
1     2.68       1.53       1.46   18 -0.50    2.07    2.03    1.90    1.86 1.98 3.35 4.63
2     1.64       2.40       2.27   16 -0.75    2.05    1.97    1.96    1.91 1.78 4.24 4.43
3     1.98       1.90       1.84   18 -0.25    2.08    2.05    1.87    1.83 2.12 3.53 3.74
4     2.11       1.80       1.74   16  1.25    1.77    1.75    2.25    2.16 6.93 3.83 1.63
5     1.75       2.14       2.09   16 -1.00    2.12    2.06    1.86    1.82 1.64 4.18 5.82
6     1.94       1.96       1.87   17 -1.00    1.90    1.86    2.05    2.01 1.53 4.48 6.91
```

El elemento 2 de la lista contiene el dataframe con los datos de la temporada 2018-2019
```R
str(data.frame(lista_archivos[2]))
head(data.frame(lista_archivos[2]))
View(data.frame(lista_archivos[2]))
summary(data.frame(lista_archivos[2]))
```
```
  Div       Date   HomeTeam   AwayTeam FTHG FTAG FTR HTHG HTAG HTR HS AS HST AST HF AF HC AC HY AY HR AR B365H B365D
1 SP1 17/08/2018      Betis    Levante    0    3   A    0    1   A 22  6   8   4 10 10  5  3  0  2  0  0  1.66  4.00
2 SP1 17/08/2018     Girona Valladolid    0    0   D    0    0   D 13  2   1   1 21 20  3  2  1  1  0  0  1.75  3.60
3 SP1 18/08/2018  Barcelona     Alaves    3    0   H    0    0   D 25  3   9   0  6 13  7  1  0  2  0  0  1.11 10.00
4 SP1 18/08/2018      Celta    Espanol    1    1   D    0    1   A 12 14   2   5 13 14  8  7  3  2  0  0  1.85  3.50
5 SP1 18/08/2018 Villarreal   Sociedad    1    2   A    1    1   D 16  8   7   4 16 10  4  6  2  3  0  0  2.04  3.40
6 SP1 19/08/2018      Eibar     Huesca    1    2   A    0    2   A 18  8   6   6 12 13  7  0  1  1  0  0  1.66  3.75
  B365A  BWH  BWD   BWA  IWH  IWD  IWA  PSH   PSD   PSA  WHH WHD   WHA  VCH  VCD  VCA Bb1X2 BbMxH BbAvH BbMxD BbAvD
1   5.0 1.70  3.7  5.25 1.75 3.60  4.9 1.69  4.19  5.11 1.67 3.9  4.75 1.67  4.2  5.2    40  1.75  1.68  4.25  4.00
2   5.0 1.75  3.5  5.25 1.80 3.60  4.5 1.80  3.70  4.99 1.75 3.6  4.60 1.80  3.7  4.8    40  1.85  1.78  3.83  3.60
3  21.0 1.11 10.0 20.00 1.12 9.00 20.0 1.11 11.27 25.40 1.08 9.0 29.00 1.10 10.5 34.0    40  1.13  1.10 11.50  9.82
4   4.5 1.91  3.4  4.25 1.90 3.50  4.1 1.93  3.64  4.27 1.91 3.5  4.00 1.93  3.5  4.4    38  1.97  1.90  3.73  3.53
5   3.8 2.05  3.3  3.90 2.00 3.40  3.8 2.06  3.51  3.91 2.05 3.3  3.60 2.05  3.5  3.9    40  2.11  2.03  3.62  3.43
6   5.5 1.70  3.7  5.25 1.70 3.75  5.0 1.72  3.90  5.26 1.73 3.6  4.75 1.70  3.8  5.0    40  1.76  1.70  3.93  3.77
  BbMxA BbAvA BbOU BbMx.2.5 BbAv.2.5 BbMx.2.5.1 BbAv.2.5.1 BbAH BbAHh BbMxAHH BbAvAHH BbMxAHA BbAvAHA PSCH  PSCD  PSCA
1  5.25  4.95   38     1.82     1.76       2.15       2.06   20 -0.75    1.89    1.85    2.07    2.00 1.59  4.42  5.89
2  5.27  4.79   38     2.21     2.13       1.78       1.71   20 -0.75    2.06    2.01    1.90    1.85 1.76  3.57  5.62
3 41.00 25.67   32     1.39     1.34       3.40       3.18   19 -2.50    1.95    1.91    2.00    1.95 1.10 11.85 32.17
4  4.50  4.20   36     2.13     2.06       1.84       1.76   18 -0.75    2.26    2.18    1.74    1.71 2.18  3.26  3.85
5  3.93  3.76   37     2.05     1.99       1.88       1.81   18 -0.25    1.76    1.74    2.23    2.14 2.32  3.21  3.53
6  5.50  5.08   37     1.95     1.88       1.98       1.91   19 -0.75    1.96    1.91    2.01    1.94 1.77  3.68  5.32
```

El elemento 3 de la lista contiene el dataframe con los datos de la temporada 2019-2020
```R
str(data.frame(lista_archivos[3]))
head(data.frame(lista_archivos[3]))
View(data.frame(lista_archivos[3]))
summary(data.frame(lista_archivos[3]))
```
```
  Div       Date  Time   HomeTeam    AwayTeam FTHG FTAG FTR HTHG HTAG HTR HS AS HST AST HF AF HC AC HY AY HR AR B365H
1 SP1 16/08/2019 20:00 Ath Bilbao   Barcelona    1    0   H    0    0   D 11 11   5   2 14  9  3  8  1  1  0  0  5.25
2 SP1 17/08/2019 16:00      Celta Real Madrid    1    3   A    0    1   A  7 17   4  11 17 12  6  4  5  2  0  1  4.75
3 SP1 17/08/2019 18:00   Valencia    Sociedad    1    1   D    0    0   D 14 12   6   3 13 14  3  3  4  4  1  0  1.66
4 SP1 17/08/2019 19:00   Mallorca       Eibar    2    1   H    1    0   H 16 11   4   5 13 14  9  3  2  3  0  0  2.80
5 SP1 17/08/2019 20:00    Leganes     Osasuna    0    1   A    0    0   D 13  4   2   2 17 11  8  0  1  4  1  0  2.00
6 SP1 17/08/2019 20:00 Villarreal     Granada    4    4   D    1    1   D 12 14   7   7 10 16  2  7  3  1  0  0  1.60
  B365D B365A  BWH  BWD  BWA  IWH  IWD  IWA  PSH  PSD  PSA  WHH WHD  WHA  VCH  VCD  VCA MaxH MaxD MaxA AvgH AvgD AvgA
1  3.80  1.65 5.50 3.80 1.65 5.00 3.80 1.70 5.15 3.84 1.74 5.00 3.8 1.70 5.00 3.80 1.75 5.50 3.95 1.76 5.07 3.81 1.71
2  4.20  1.65 4.40 4.20 1.72 5.30 4.20 1.60 4.73 4.18 1.72 5.25 4.2 1.60 4.75 4.20 1.73 5.30 4.40 1.73 4.67 4.12 1.69
3  3.75  5.50 1.67 3.75 5.50 1.67 3.75 5.30 1.68 3.94 5.47 1.67 3.8 5.25 1.67 3.90 5.75 1.72 3.98 5.75 1.68 3.80 5.29
4  3.20  2.60 2.95 3.10 2.60 2.90 3.10 2.60 2.98 3.14 2.66 2.90 3.1 2.62 2.90 3.13 2.70 3.05 3.20 2.70 2.91 3.09 2.62
5  3.20  4.20 2.05 3.25 3.90 2.05 3.10 4.05 2.10 3.21 4.13 2.05 3.2 4.00 2.10 3.20 4.10 2.10 3.30 4.25 2.06 3.18 4.02
6  3.80  6.50 1.60 3.80 6.25 1.63 4.00 5.50 1.62 3.99 6.13 1.60 3.9 5.80 1.65 4.00 5.75 1.65 4.15 6.50 1.61 3.95 5.80
  B365.2.5 B365.2.5.1 P.2.5 P.2.5.1 Max.2.5 Max.2.5.1 Avg.2.5 Avg.2.5.1   AHh B365AHH B365AHA PAHH PAHA MaxAHH MaxAHA
1     1.80       2.00  1.81    2.09    1.85      2.11    1.79      2.05  0.75    1.99    1.94 1.98 1.94   2.00   1.95
2     1.53       2.50  1.52    2.66    1.53      2.72    1.49      2.58  0.75    2.04    1.89 2.01 1.91   2.05   1.91
3     2.00       1.80  2.08    1.82    2.14      1.83    2.07      1.77 -0.75    1.91    2.02 1.91 2.01   1.93   2.03
4     2.30       1.61  2.45    1.60    2.47      1.65    2.34      1.60  0.00    2.05    1.88 2.07 1.85   2.07   1.88
5     2.50       1.53  2.72    1.50    2.75      1.54    2.59      1.49 -0.50    2.08    1.85 2.10 1.82   2.10   1.85
6     1.80       2.00  1.88    2.02    1.90      2.05    1.84      1.98 -1.00    2.05    1.75 2.11 1.81   2.14   1.85
  AvgAHH AvgAHA B365CH B365CD B365CA BWCH BWCD BWCA IWCH IWCD IWCA PSCH PSCD PSCA WHCH WHCD WHCA VCCH VCCD VCCA MaxCH
1   1.96   1.92   5.25   3.80   1.65 4.75 3.75 1.75 5.00 3.80 1.70 5.34 3.62 1.78 5.00  3.8 1.70 4.80 3.80 1.80  5.80
2   2.00   1.88   5.25   4.20   1.57 4.50 4.10 1.70 4.60 3.80 1.75 5.10 4.46 1.65 5.00  4.2 1.63 5.20 4.40 1.65  6.00
3   1.89   1.99   1.66   3.75   5.50 1.65 3.80 5.50 1.67 3.80 5.30 1.69 3.88 5.47 1.65  3.9 5.25 1.70 3.90 5.50  1.72
4   2.04   1.85   2.87   3.20   2.55 2.95 3.10 2.60 2.90 3.10 2.60 2.96 3.26 2.60 2.90  3.1 2.60 3.00 3.13 2.63  3.05
5   2.06   1.83   1.90   3.10   5.00 1.95 3.20 4.50 1.90 3.15 4.85 1.90 3.18 5.30 2.05  3.2 4.00 1.90 3.20 5.20  1.95
6   2.07   1.80   1.53   4.00   6.50 1.57 3.80 6.50 1.55 4.05 6.30 1.54 4.19 6.87 1.62  3.9 5.80 1.57 4.00 7.00  1.58
  MaxCD MaxCA AvgCH AvgCD AvgCA B365C.2.5 B365C.2.5.1 PC.2.5 PC.2.5.1 MaxC.2.5 MaxC.2.5.1 AvgC.2.5 AvgC.2.5.1  AHCh
1  3.90  1.81  5.03  3.66  1.76      1.90        1.90   1.98     1.93     1.99       2.11     1.86       1.97  0.75
2  4.52  1.75  4.93  4.26  1.65      1.44        2.75   1.49     2.76     1.51       2.88     1.47       2.63  1.00
3  3.95  6.20  1.68  3.82  5.37      2.00        1.80   2.06     1.85     2.08       1.98     2.00       1.82 -0.75
4  3.29  2.72  2.93  3.14  2.59      2.20        1.66   2.20     1.74     2.38       1.74     2.24       1.66  0.00
5  3.26  5.30  1.90  3.16  4.91      2.75        1.44   2.84     1.47     2.85       1.50     2.69       1.46 -0.50
6  4.20  7.30  1.54  4.05  6.66      1.90        1.90   1.95     1.95     1.98       2.10     1.90       1.92 -1.00
  B365CAHH B365CAHA PCAHH PCAHA MaxCAHH MaxCAHA AvgCAHH AvgCAHA
1     1.93     2.00  1.91  2.01    2.02    2.03    1.91    1.98
2     1.82     1.97  1.85  2.07    2.00    2.20    1.82    2.06
3     1.94     1.99  1.92  2.00    1.96    2.12    1.89    2.00
4     2.11     1.82  2.09  1.83    2.12    1.88    2.07    1.83
5     1.89     2.04  1.90  2.01    1.95    2.06    1.90    1.99
6     1.96     1.97  1.96  1.96    1.98    2.12    1.93    1.95
```

Creo una lista con las columnas seleccionadas de cada dataframe
```R
lista_columnas <- lapply(lista_archivos, select, c("Date", "HomeTeam", "AwayTeam", "FTHG", "FTAG", "FTR"))
length(lista_columnas) #La lista contiene 3 elementos que son un dataframe de las columnas seleccionadas por cada temporada
str(data.frame(lista_columnas[1]))
str(data.frame(lista_columnas[2]))
str(data.frame(lista_columnas[3]))
```
```
> [1] 3

> 'data.frame':	380 obs. of  6 variables:
 $ Date    : chr  "18/08/17" "18/08/17" "19/08/17" "19/08/17" ...
 $ HomeTeam: chr  "Leganes" "Valencia" "Celta" "Girona" ...
 $ AwayTeam: chr  "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
 $ FTHG    : int  1 1 2 2 1 0 2 0 1 0 ...
 $ FTAG    : int  0 0 3 2 1 0 0 3 0 1 ...
 $ FTR     : chr  "H" "H" "A" "D" ...

> 'data.frame':	380 obs. of  6 variables:
 $ Date    : chr  "17/08/2018" "17/08/2018" "18/08/2018" "18/08/2018" ...
 $ HomeTeam: chr  "Betis" "Girona" "Barcelona" "Celta" ...
 $ AwayTeam: chr  "Levante" "Valladolid" "Alaves" "Espanol" ...
 $ FTHG    : int  0 0 3 1 1 1 2 1 2 1 ...
 $ FTAG    : int  3 0 0 1 2 2 0 4 1 1 ...
 $ FTR     : chr  "A" "D" "H" "D" ...
```

La columa "Date" de los dataframes es de clase caracter. Debemos de cambiarla a clase Date
El formato es diferente para cada dataframe
```R
tmp2017.2018.dfcols <- mutate(data.frame(lista_columnas[1]), Date = as.Date(Date, "%d/%m/%y"))
tmp2018.2019.dfcols <- mutate(data.frame(lista_columnas[2]), Date = as.Date(Date, "%d/%m/%Y"))
tmp2019.2020.dfcols <- mutate(data.frame(lista_columnas[3]), Date = as.Date(Date, "%d/%m/%Y"))
```
Ahora comprobamos que la columna "Date" sea clase Date.
```R
class(tmp2017.2018.dfcols$Date)
class(tmp2018.2019.dfcols$Date)
class(tmp2019.2020.dfcols$Date)
```

Por ultimo unimos todos los dataframes en uno solo
```R
lista_final <- list(tmp2017.2018.dfcols,tmp2018.2019.dfcols,tmp2019.2020.dfcols)
df.todo.final <- do.call(rbind, lista_final)
str(df.todo.final)
```
```
'data.frame':	1140 obs. of  6 variables:
 $ Date    : Date, format: "2017-08-18" "2017-08-18" "2017-08-19" "2017-08-19" ...
 $ HomeTeam: chr  "Leganes" "Valencia" "Celta" "Girona" ...
 $ AwayTeam: chr  "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
 $ FTHG    : int  1 1 2 2 1 0 2 0 1 0 ...
 $ FTAG    : int  0 0 3 2 1 0 0 3 0 1 ...
 $ FTR     : chr  "H" "H" "A" "D" ...
```

Guardamos el dataframe final para usarlo en la sesion 3
```R
write.csv(df.todo.final, file = "Fut.ligaEsp.Postwork2.csv", sep = ",", col.names=TRUE, row.names = FALSE)
```
## Postwork sesion 3

```R
library(dplyr)
library(ggplot2)
```

Importar y leer el archivo resultado del postwork 2; datos de la liga española de futbol
```R
Fut.ligaEsp <- read.csv("https://raw.githubusercontent.com/AngelicaDC/Postworks_BEDU/main/data/Fut.ligaEsp.Postwork2.csv")
str(Fut.ligaEsp)
```
```
'data.frame':	1140 obs. of  6 variables:
 $ Date    : chr  "2017-08-18" "2017-08-18" "2017-08-19" "2017-08-19" ...
 $ HomeTeam: chr  "Leganes" "Valencia" "Celta" "Girona" ...
 $ AwayTeam: chr  "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
 $ FTHG    : int  1 1 2 2 1 0 2 0 1 0 ...
 $ FTAG    : int  0 0 3 2 1 0 0 3 0 1 ...
 $ FTR     : chr  "H" "H" "A" "D" ...
```

Goles anotados por los equipos que jugaron en casa (FTHG) y los visitantes (FTAG)

Encontrar la probabilidad marginal de que la casa anote `x` goles a partir de las frec. relativas
```R
Frec.abs.FTHG <- table(Fut.ligaEsp$FTHG) #Frecuencias absolutas
pmarg.golesCasa <- prop.table(Frec.abs.FTHG) #Probabilidades marginales
```

Encontrar la probabilidad marginal de que el visitante anote `y` goles a partir de las frec. relativas
```R
Frec.abs.FTAG <- table(Fut.ligaEsp$FTAG) #Frecuencias absolutas
pmarg.golesVisitante <- prop.table(Frec.abs.FTAG) #Probabilidades marginales
```

Encontrar probabilidad conjunta de que la casa anote `x` goles y el visitante `y` goles
```R
Frec.abs.ambos <- table(Fut.ligaEsp$FTHG, Fut.ligaEsp$FTAG)
prob.conjunta <- prop.table(Frec.abs.ambos) #Probabilidades conjunta
```

Crear dataframes de probablidades para poder usar ggplot
```R
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
```

Unir dataframes para hacer un grafico de barras que represente a ambos equipos
```R
df.goles.ambos <- rbind(df.goles.casa, df.goles.visitante)
sort(df.goles.ambos$Freq)
```

Graficar las probabilidades marginales de cada equipo
```R
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
```
<p align="center"><img src="img/Prob-anot-goles.png" /></p>


Graficar la probabilidad conjunta
```R
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
```
<p align="center"><img src="img/prob-casa-vs-visit.png" /></p>

### Postwork 4
Importar y leer el archivo resultado del postwork 2; datos de la liga española de futbol
```R
Fut.ligaEsp <- read.csv("https://raw.githubusercontent.com/AngelicaDC/Postworks_BEDU/main/data/Fut.ligaEsp.Postwork2.csv")
View(Fut.ligaEsp)
dim(Fut.ligaEsp)
```
```
> [1] 1140    6
```

Encontrar la probabilidad marginal de que la casa anote `x` goles a partir de las frec. relativas
```R
Frec.abs.FTH <- table(Fut.ligaEsp$FTHG) #Frecuencias absolutas
(pmarg.golesCasa <- c(prop.table(Frec.abs.FTHG))) #Probabilidades marginales
```
```
          0           1           2           3           4           5           6           7           8 
0.232456140 0.327192982 0.266666667 0.112280702 0.035087719 0.019298246 0.005263158 0.000877193 0.000877193 
```

Encontrar la probabilidad marginal de que el visitante anote `y` goles a partir de las frec. relativas
```R
Frec.abs.FTAG <- table(Fut.ligaEsp$FTAG) #Frecuencias absolutas
(pmarg.golesVisitante <- c(prop.table(Frec.abs.FTAG))) #Probabilidades marginales
```
```
          0           1           2           3           4           5           6 
0.351754386 0.340350877 0.212280702 0.054385965 0.028947368 0.009649123 0.002631579 
```

Encontrar probabilidad conjunta de que la casa anote `x` goles y el visitante `y` goles
```R
Frec.abs.ambos <- table(Fut.ligaEsp$FTHG, Fut.ligaEsp$FTAG)
(prob.conjunta <- prop.table(Frec.abs.ambos)) #Probabilidades conjunta
```
```
  
              0           1           2           3           4           5           6
  0 0.078070175 0.080701754 0.045614035 0.018421053 0.005263158 0.004385965 0.000000000
  1 0.115789474 0.114912281 0.068421053 0.017543860 0.008771930 0.001754386 0.000000000
  2 0.087719298 0.093859649 0.061403509 0.011403509 0.008771930 0.001754386 0.001754386
  3 0.044736842 0.032456140 0.024561404 0.006140351 0.001754386 0.001754386 0.000877193
  4 0.014035088 0.010526316 0.007017544 0.000000000 0.003508772 0.000000000 0.000000000
  5 0.008771930 0.005263158 0.004385965 0.000000000 0.000877193 0.000000000 0.000000000
  6 0.002631579 0.001754386 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000
  7 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
  8 0.000000000 0.000000000 0.000877193 0.000000000 0.000000000 0.000000000 0.000000000
```

#### Obter una tabla de cocientes
Dividimos las probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
Calculamos el producto de probabilidades marginales
```R
produto.pmarginales <- pmarg.golesCasa%*%t(pmarg.golesVisitante)
produto.pmarginales
```
```
                 0            1            2            3            4            5            6
 [1,] 0.0817674669 0.0791166513 0.0493459526 1.264235e-02 6.728994e-03 2.242998e-03 6.117267e-04
 [2,] 0.1150915666 0.1113604186 0.0694567559 1.779471e-02 9.471376e-03 3.157125e-03 8.610342e-04
 [3,] 0.0938011696 0.0907602339 0.0566081871 1.450292e-02 7.719298e-03 2.573099e-03 7.017544e-04
 [4,] 0.0394952293 0.0382148353 0.0238350262 6.106494e-03 3.250231e-03 1.083410e-03 2.954755e-04
 [5,] 0.0123422592 0.0119421360 0.0074484457 1.908279e-03 1.015697e-03 3.385657e-04 9.233610e-05
 [6,] 0.0067882425 0.0065681748 0.0040966451 1.049554e-03 5.586334e-04 1.862111e-04 5.078486e-05
 [7,] 0.0018513389 0.0017913204 0.0011172669 2.862419e-04 1.523546e-04 5.078486e-05 1.385042e-05
 [8,] 0.0003085565 0.0002985534 0.0001862111 4.770699e-05 2.539243e-05 8.464143e-06 2.308403e-06
 [9,] 0.0003085565 0.0002985534 0.0001862111 4.770699e-05 2.539243e-05 8.464143e-06 2.308403e-06
```

Calculamos el cociente de la probabilidad conjunta sobre el producto de probabilidades marginales
```R
(cociente <- prob.conjunta/produto.pmarginales)
dim(cociente)
```
```
>   
            0         1         2         3         4         5         6
  0 0.9547829 1.0200350 0.9243724 1.4570907 0.7821612 1.9554031 0.0000000
  1 1.0060639 1.0318952 0.9850885 0.9859033 0.9261516 0.5556910 0.0000000
  2 0.9351621 1.0341495 1.0847107 0.7862903 1.1363636 0.6818182 2.5000000
  3 1.1327151 0.8493073 1.0304752 1.0055444 0.5397727 1.6193182 2.9687500
  4 1.1371571 0.8814433 0.9421488 0.0000000 3.4545455 0.0000000 0.0000000
  5 1.2922240 0.8013121 1.0706236 0.0000000 1.5702479 0.0000000 0.0000000
  6 1.4214464 0.9793814 0.0000000 3.0645161 0.0000000 0.0000000 0.0000000
  7 0.0000000 2.9381443 0.0000000 0.0000000 0.0000000 0.0000000 0.0000000
  8 0.0000000 0.0000000 4.7107438 0.0000000 0.0000000 0.0000000 0.0000000

> [1] 9 7
```
### Generación de boostrap sobre los datos
Hacemos un bootstrap para generar datos y usamos replace para que se permitan valores repetidos
```R
df_hv= paste(Fut.ligaEsp$FTHG, Fut.ligaEsp$FTAG)
class(df_hv)
df_hv
```
`[1] "character"`
```
> df_hv
   [1] "1 0" "1 0" "2 3" "2 2" "1 1" "0 0" "2 0" "0 3" "1 0" "0 1" "2 1" "3 0" "0 2"
...
 [989] "2 1" "2 3" "2 2" "1 0" "2 1" "2 1" "2 1" "2 2" "0 0" "0 1" "2 2" "3 3"
 [ reached getOption("max.print") -- omitted 140 entries ]
```

Generamos 1000 muestras

```R
set.seed(12345)
bhv = replicate(n=1000, sample(df_hv, replace = TRUE))
#bhv
```

Se utiliza la siguiente funcion para empaquetar los resultados de los partidos.

```R
reformat <- function(s) {
  unlist(lapply(strsplit(s, ' '), strtoi))
}
```
```R
ref=apply(bhv, 1, reformat)

View(ref)
class(bhv)
dim(ref)
```
||v1|v2|v3|...|
|-|-|-|-|-|
|1|0|1|0||
|1|0|2|1||
|...|||||
```
> class(bhv)
[1] "matrix" "array"
> dim(ref)
[1] 2000 1140 
```

```R
nones <- seq(1,dim(ref)[1],2)
pares <- seq(2,dim(ref)[1],2)

casa <- as.matrix(ref[nones,])
casa <- t(casa)

visita <- as.matrix(ref[pares,])
visita <- t(visita)
dim(visita)
```
```
[1] 1140 1000
```

```R
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
```
|Var1| Var2|    Medias|    varianza|
|-|-|-|-|
|1     |0|    0| 0.9599280| 0.005308736|
|2     |0|    1| 1.0228705| 0.005549046|
|3     |0|    2| 0.9188134| 0.009232376|
|4     |0|    3| 1.4293345| 0.066867590|
|5     |0|    4| 0.7862167| 0.081905245|
|6     |0|    5| 1.9274841| 0.476490580|
|7     |0|    6| 0.0000000| 0.000000000|
|8     |1|    0| 1.0035822| 0.003219892|
|...|||||

Sacamos la media y la varianza para cada uno de los 63 cocientes
```R
medias <- chiquito$Medias
varianzas <- chiquito$varianza
```

Calculo estadistico de prueba para una muestra grande.
### H0: Mu=1
### Ha: Mu!=1

Calculamos el estadistico de prueba para los valores de los cocientes.
Usamos la varianza obtenida a partir de bootstrap

```R
(z0 <- (cociente-1)/sqrt(varianzas/63))
```
```
               0            1            2            3            4            5            6
  0   -4.9258122    1.9625216   -1.9882483    1.3016450   -6.1252698    2.4871799         -Inf
  1    0.6461230    1.4197815   -0.2444047   -0.5041213   -1.3401534         -Inf         -Inf
  2   -5.3560238    1.1025246    0.5704791   -8.0615523          Inf         -Inf          Inf
  3    4.0736408   -3.1726911    2.0874013    0.1490621   -2.2369492          Inf  125.6324130
  4    3.8039319         -Inf   -4.1437735         -Inf          Inf         -Inf         -Inf
  5    3.3601524  -23.6414712    3.3680419   -4.8515613          Inf         -Inf         -Inf
  6          Inf   -2.4196671  -23.0240719          Inf  -12.5952724  -29.4831256         -Inf
  7 -139.8780603  163.0327416  -20.6280892         -Inf  -12.9309968         -Inf         -Inf
  8 -139.5223199  -40.6748732   26.8321666  -25.4921159         -Inf         -Inf         -Inf
```
Y para comparar, calculamos tambien el estadistico de prueba es uno para cada uno de los 63 cocientes del bootstrap.

```R
(z0b <- (medias-1)/sqrt(varianzas/63))
```
```
[1]  -4.3653119   2.4368981  -6.7065292  13.1782642  -5.9290912  10.6647230        -Inf   0.5010683   4.4127669
[10]  -1.1337589  -0.6119235  -2.3102011  -8.9506204        -Inf  -7.9450568   4.0055249   7.1545604  -8.2024621
[19]   3.5408918  -5.3631169  10.2901826   9.1064689 -10.9231970   1.2442273   0.5624191  -9.2996982   4.6074413
[28]   5.4467680   5.0662579  -4.3754921  -1.4169223        -Inf  11.4956050        -Inf        -Inf   7.3778356
[37]  -5.9646361   1.6583225        -Inf   3.1620914        -Inf        -Inf   5.3639229  -0.3965892        -Inf
[46]   5.4524344        -Inf        -Inf        -Inf        -Inf        -Inf 109.3778437        -Inf        -Inf
[55]        -Inf        -Inf        -Inf 123.6901311        -Inf        -Inf        -Inf        -Inf        -Inf
```
```R
#Reorganizamos z0b
z0b <- t(matrix(z0b, nrow = 7, ncol = 9))
```

Encontrar region de rechazo para dos colas porque la hipotesis alternativa es `Mu!=1`
Queremos que `alfa=0.1`. Dividimos `alfa/2=0.05`. Sacamos `z05` para ambas colas.
```R
(z.025.arriba <- qnorm(p = 0.025, lower.tail = FALSE)) #z0 tiene que ser mas alta que z.05.arriba 
```
> [1] 1.959964

```R
(z.025.abajo <- qnorm(p = 0.025, lower.tail = TRUE)) #z0 tiene que ser mas baja que z.05.abajo
```
> [1] -1.959964

Comprobar o rechazar hipotesis nula de que los valores de los cocientes son iguales a 1.
Region de rechazo de hipotesis nula `Z0 > z.05.arriba` o `Z0 < z.05.abajo`.

```R
(rechazo.cociente <- (z0 > z.025.arriba) | (z0 < z.025.abajo)) #Los valores de la primer tabal cocientes tiene que ser mas baja que z.05.abajo 
```
```
       0     1     2     3     4    5    6
  0  TRUE  TRUE  TRUE FALSE  TRUE TRUE TRUE
  1 FALSE FALSE FALSE FALSE FALSE TRUE TRUE
  2  TRUE FALSE FALSE  TRUE  TRUE TRUE TRUE
  3  TRUE  TRUE  TRUE FALSE  TRUE TRUE TRUE
  4  TRUE  TRUE  TRUE  TRUE  TRUE TRUE TRUE
  5  TRUE  TRUE  TRUE  TRUE  TRUE TRUE TRUE
  6  TRUE  TRUE  TRUE  TRUE  TRUE TRUE TRUE
  7  TRUE  TRUE  TRUE  TRUE  TRUE TRUE TRUE
  8  TRUE  TRUE  TRUE  TRUE  TRUE TRUE TRUE
```

O mas grandes que `z.05.arriba`
```R 
rechazo.samples <- (z0b > z.025.arriba) | (z0b < z.025.abajo) #Comparamos con las medias del bootstrap
rownames(rechazo.samples) = c("0","1","2","3","4","5","6","7","8")
colnames(rechazo.samples) = c("0","1","2","3","4","5","6")
rechazo.samples
```
||0|     1|     2|     3|    4|    5|    6|
|-|-|-|-|-|-|-|-|
|0|  TRUE|  TRUE|  TRUE|  TRUE| TRUE| TRUE| TRUE|
|1| FALSE|  TRUE| FALSE| FALSE| TRUE| TRUE| TRUE|
|2|  TRUE|  TRUE|  TRUE|  TRUE| TRUE| TRUE| TRUE|
|3|  TRUE|  TRUE| FALSE| FALSE| TRUE| TRUE| TRUE|
|4|  TRUE|  TRUE| FALSE|  TRUE| TRUE| TRUE| TRUE|
|5|  TRUE|  TRUE| FALSE|  TRUE| TRUE| TRUE| TRUE|
|6|  TRUE| FALSE|  TRUE|  TRUE| TRUE| TRUE| TRUE|
|7|  TRUE|  TRUE|  TRUE|  TRUE| TRUE| TRUE| TRUE|
|8|  TRUE|  TRUE|  TRUE|  TRUE| TRUE| TRUE| TRUE|

### Los valores `TRUE` nos indican en que casos se rechaza la hipotesis nula, es decir que existe una dependencia entre las variables `x` y `y`
### Los valores `FALSE` nos indican en que casos que no se rechaza `H0`, es decir que las variables `x` y `y` son independientes.


# Segunda Etapa

## Postwork 7
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
