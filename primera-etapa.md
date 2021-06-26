# Postwork Primera Etapa
A continuacion se muestra el procedimiento utilizado para cumplir con todos los puntos planteados dentro de los postworks de la 1ra a la 4ta sesión.

## Postwork sesion1
Importamos el data set de la liga de futbol espanola 2019-2020 usando la funcion read.csv() desde el URL.
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
            i,"goles es: ", frec.rel.goles.casa[i]
        )
    )
}
```
> La probabilidad marginal de que la casa anote 1 goles es:  0.231578947368421
> 
> La probabilidad marginal de que la casa anote 2 goles es:  0.347368421052632
> 
> La probabilidad marginal de que la casa anote 3 goles es:  0.260526315789474
> 
> La probabilidad marginal de que la casa anote 4 goles es:  0.1
> 
> La probabilidad marginal de que la casa anote 5 goles es:  0.0368421052631579
> 
> La probabilidad marginal de que la casa anote 6 goles es:  0.0210526315789474
> 
> La probabilidad marginal de que la casa anote 7 goles es:  0.00263157894736842

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

Tabla de probabilidad conjunto de "x" goles del equipo de casa vs "y" goles del visitante
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


## Postwork sesion 2
Creamos una lista con las direcciones donde se encuentran los archivos de futbol de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española
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
'data.frame':	380 obs. of  64 variables:
 $ Div       : chr  "SP1" "SP1" "SP1" "SP1" ...
 $ Date      : chr  "18/08/17" "18/08/17" "19/08/17" "19/08/17" ...
 $ HomeTeam  : chr  "Leganes" "Valencia" "Celta" "Girona" ...
 $ AwayTeam  : chr  "Alaves" "Las Palmas" "Sociedad" "Ath Madrid" ...
 $ FTHG      : int  1 1 2 2 1 0 2 0 1 0 ...
 $ FTAG      : int  0 0 3 2 1 0 0 3 0 1 ...
 $ FTR       : chr  "H" "H" "A" "D" ...
 $ HTHG      : int  1 1 1 2 1 0 2 0 0 0 ...
 $ HTAG      : int  0 0 1 0 1 0 0 2 0 0 ...
 $ HTR       : chr  "H" "H" "D" "H" ...
 $ HS        : int  16 22 16 13 9 12 15 12 14 10 ...
 $ AS        : int  6 5 13 9 9 8 3 16 9 13 ...
 $ HST       : int  9 6 5 6 4 2 2 6 3 4 ...
 $ AST       : int  3 4 6 3 6 2 0 8 1 6 ...
 $ HF        : int  14 25 12 15 14 16 16 16 18 16 ...
 $ AF        : int  18 13 11 15 12 15 15 12 14 15 ...
 $ HC        : int  4 5 5 6 7 7 8 4 11 3 ...
 $ AC        : int  2 2 4 0 3 6 0 4 6 7 ...
 $ HY        : int  0 3 3 2 2 1 2 5 1 2 ...
 $ AY        : int  1 3 1 4 4 3 1 1 3 3 ...
 $ HR        : int  0 0 0 0 1 0 0 0 0 0 ...
 $ AR        : int  0 1 0 1 0 1 0 1 0 0 ...
 $ B365H     : num  2.05 1.75 2.38 8 1.62 1.5 1.17 9.5 3.25 2.1 ...
 $ B365D     : num  3.2 3.8 3.25 4.33 4 4 8 5.75 3.25 3.3 ...
 $ B365A     : num  4.1 4.5 3.2 1.45 5.5 7.5 15 1.3 2.3 3.7 ...
 $ BWH       : num  2.05 1.75 2.4 7.5 1.62 1.48 1.18 9.25 3.25 2.15 ...
 $ BWD       : num  3.1 3.9 3.3 4.33 3.9 4.25 7.5 5.75 3.2 3.3 ...
 $ BWA       : num  4.1 4.6 3 1.45 5.75 7 14.5 1.3 2.3 3.5 ...
 $ IWH       : num  2.1 1.75 2.5 7.2 1.55 1.5 1.17 7.5 3.3 2.1 ...
 $ IWD       : num  3.4 3.6 3.3 4.4 4 4.2 7.5 5.5 3.35 3.4 ...
 $ IWA       : num  3.5 4.8 2.85 1.45 6.2 6.5 15 1.35 2.2 3.5 ...
 $ LBH       : num  2.05 1.75 2.35 7.5 1.6 1.5 1.2 9.5 3.25 2.1 ...
 $ LBD       : num  3 3.8 3.25 4 3.9 4 6.5 5.25 3.1 3.1 ...
 $ LBA       : num  4.2 4.33 3 1.5 5.5 7 15 1.3 2.3 3.4 ...
 $ PSH       : num  2.03 1.78 2.44 8.36 1.62 ...
 $ PSD       : num  3.25 4.01 3.4 4.38 4.17 4.37 7.35 5.79 3.24 3.36 ...
 $ PSA       : num  4.52 4.83 3.16 1.49 6.18 7.31 15.5 1.33 2.36 3.49 ...
 $ WHH       : num  2.05 1.8 2.4 8 1.67 1.5 1.22 11 3.1 2.2 ...
 $ WHD       : num  3.1 3.75 3.4 4.2 3.6 4 6 4.5 3.1 3.3 ...
 $ WHA       : num  4 4.2 2.9 1.44 5.5 7 13 1.33 2.4 3.3 ...
 $ VCH       : num  2.05 1.8 2.4 7.5 1.65 1.5 1.2 9.5 3.25 2.15 ...
 $ VCD       : num  3.2 4 3.4 4.3 4 4.2 7 5.75 3.25 3.3 ...
 $ VCA       : num  4.4 4.6 3.13 1.5 5.75 7 13 1.3 2.3 3.5 ...
 $ Bb1X2     : int  35 35 35 35 35 34 35 35 34 34 ...
 $ BbMxH     : num  2.12 1.83 2.5 8.36 1.69 ...
 $ BbAvH     : num  2.03 1.77 2.39 7.53 1.63 1.5 1.19 9.68 3.26 2.18 ...
 $ BbMxD     : num  3.4 4.04 3.5 4.4 4.17 4.4 8 5.86 3.35 3.4 ...
 $ BbAvD     : num  3.15 3.86 3.32 4.17 3.93 4.17 7.11 5.44 3.17 3.26 ...
 $ BbMxA     : num  4.52 4.83 3.2 1.51 6.2 7.5 17 1.35 2.4 3.7 ...
 $ BbAvA     : num  4.17 4.46 3.01 1.48 5.58 ...
 $ BbOU      : int  31 33 34 34 33 32 27 27 32 32 ...
 $ BbMx.2.5  : num  2.84 1.69 2.03 2.2 1.81 2.01 1.44 1.5 2.42 2.25 ...
 $ BbAv.2.5  : num  2.68 1.64 1.98 2.11 1.75 1.94 1.4 1.46 2.36 2.14 ...
 $ BbMx.2.5.1: num  1.53 2.4 1.9 1.8 2.14 1.96 3.1 2.95 1.63 1.76 ...
 $ BbAv.2.5.1: num  1.46 2.27 1.84 1.74 2.09 1.87 2.88 2.64 1.58 1.7 ...
 $ BbAH      : int  18 16 18 16 16 17 17 16 15 17 ...
 $ BbAHh     : num  -0.5 -0.75 -0.25 1.25 -1 -1 -2 1.5 0.25 -0.25 ...
 $ BbMxAHH   : num  2.07 2.05 2.08 1.77 2.12 1.9 2.05 2.03 1.93 1.92 ...
 $ BbAvAHH   : num  2.03 1.97 2.05 1.75 2.06 1.86 2 1.98 1.89 1.88 ...
 $ BbMxAHA   : num  1.9 1.96 1.87 2.25 1.86 2.05 1.91 1.95 2.03 2.04 ...
 $ BbAvAHA   : num  1.86 1.91 1.83 2.16 1.82 2.01 1.86 1.89 1.98 1.99 ...
 $ PSCH      : num  1.98 1.78 2.12 6.93 1.64 1.53 1.2 12.4 3.31 2.2 ...
 $ PSCD      : num  3.35 4.24 3.53 3.83 4.18 4.48 8.25 7 3.32 3.27 ...
 $ PSCA      : num  4.63 4.43 3.74 1.63 5.82 6.91 15.2 1.26 2.4 3.85 ...
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
```     Div                Date             HomeTeam           AwayTeam        
 Length:380         Length:380         Length:380         Length:380        
 Class :character   Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character   Mode  :character                                                      
                                                                            
      FTHG            FTAG           FTR                 HTHG             HTAG       
 Min.   :0.000   Min.   :0.000   Length:380         Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.750   1st Qu.:0.000   Class :character   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :1.000   Median :1.000   Mode  :character   Median :0.0000   Median :0.0000  
 Mean   :1.547   Mean   :1.147                      Mean   :0.6605   Mean   :0.4868  
 3rd Qu.:2.000   3rd Qu.:2.000                      3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :7.000   Max.   :6.000                      Max.   :5.0000   Max.   :3.0000  
                                                                                     
     HTR                  HS              AS             HST              AST        
 Length:380         Min.   : 2.00   Min.   : 1.00   Min.   : 0.000   Min.   : 0.000  
 Class :character   1st Qu.:10.00   1st Qu.: 8.00   1st Qu.: 3.000   1st Qu.: 2.000  
 Mode  :character   Median :13.00   Median :10.00   Median : 4.500   Median : 3.000  
                    Mean   :13.53   Mean   :10.47   Mean   : 4.758   Mean   : 3.805  
                    3rd Qu.:16.00   3rd Qu.:13.00   3rd Qu.: 6.000   3rd Qu.: 5.000  
                    Max.   :30.00   Max.   :24.00   Max.   :14.000   Max.   :13.000  
                                                                                     
       HF              AF              HC               AC               HY       
 Min.   : 4.00   Min.   : 0.00   Min.   : 0.000   Min.   : 0.000   Min.   :0.000  
 1st Qu.:11.00   1st Qu.:11.00   1st Qu.: 4.000   1st Qu.: 2.000   1st Qu.:1.000  
 Median :13.00   Median :14.00   Median : 5.000   Median : 4.000   Median :2.000  
 Mean   :13.73   Mean   :13.95   Mean   : 5.613   Mean   : 4.192   Mean   :2.339  
 3rd Qu.:17.00   3rd Qu.:17.00   3rd Qu.: 7.000   3rd Qu.: 6.000   3rd Qu.:3.000  
 Max.   :29.00   Max.   :29.00   Max.   :16.000   Max.   :14.000   Max.   :8.000  
                                                                                  
       AY              HR               AR              B365H            B365D       
 Min.   :0.000   Min.   :0.0000   Min.   :0.00000   Min.   : 1.050   Min.   : 2.790  
 1st Qu.:2.000   1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.: 1.617   1st Qu.: 3.290  
 Median :3.000   Median :0.0000   Median :0.00000   Median : 2.075   Median : 3.500  
 Mean   :2.676   Mean   :0.1105   Mean   :0.07895   Mean   : 2.777   Mean   : 4.259  
 3rd Qu.:4.000   3rd Qu.:0.0000   3rd Qu.:0.00000   3rd Qu.: 2.790   3rd Qu.: 4.330  
 Max.   :9.000   Max.   :2.0000   Max.   :2.00000   Max.   :17.000   Max.   :15.000  
                                                                                     
     B365A             BWH              BWD              BWA              IWH        
 Min.   : 1.170   Min.   : 1.050   Min.   : 2.950   Min.   : 1.180   Min.   : 1.070  
 1st Qu.: 2.600   1st Qu.: 1.650   1st Qu.: 3.300   1st Qu.: 2.600   1st Qu.: 1.650  
 Median : 3.700   Median : 2.100   Median : 3.600   Median : 3.700   Median : 2.100  
 Mean   : 5.192   Mean   : 2.744   Mean   : 4.278   Mean   : 5.204   Mean   : 2.721  
 3rd Qu.: 5.500   3rd Qu.: 2.750   3rd Qu.: 4.330   3rd Qu.: 5.500   3rd Qu.: 2.700  
 Max.   :34.000   Max.   :14.500   Max.   :15.500   Max.   :34.000   Max.   :15.000  
                                                                                     
      IWD              IWA              LBH              LBD              LBA        
 Min.   : 3.050   Min.   : 1.200   Min.   : 1.050   Min.   : 2.900   Min.   : 1.170  
 1st Qu.: 3.300   1st Qu.: 2.600   1st Qu.: 1.610   1st Qu.: 3.250   1st Qu.: 2.575  
 Median : 3.500   Median : 3.500   Median : 2.050   Median : 3.500   Median : 3.600  
 Mean   : 4.161   Mean   : 5.041   Mean   : 2.742   Mean   : 4.152   Mean   : 5.375  
 3rd Qu.: 4.200   3rd Qu.: 5.300   3rd Qu.: 2.750   3rd Qu.: 4.200   3rd Qu.: 5.500  
 Max.   :12.000   Max.   :27.000   Max.   :19.000   Max.   :17.000   Max.   :41.000  
                                   NA's   :1        NA's   :1        NA's   :1       
      PSH              PSD              PSA              WHH              WHD        
 Min.   : 1.050   Min.   : 3.020   Min.   : 1.180   Min.   : 1.060   Min.   : 2.900  
 1st Qu.: 1.660   1st Qu.: 3.410   1st Qu.: 2.670   1st Qu.: 1.665   1st Qu.: 3.250  
 Median : 2.120   Median : 3.705   Median : 3.845   Median : 2.100   Median : 3.500  
 Mean   : 2.857   Mean   : 4.539   Mean   : 5.522   Mean   : 2.738   Mean   : 4.092  
 3rd Qu.: 2.850   3rd Qu.: 4.455   3rd Qu.: 5.942   3rd Qu.: 2.750   3rd Qu.: 4.200  
 Max.   :19.650   Max.   :20.380   Max.   :36.500   Max.   :17.000   Max.   :15.000  
                                                                                     
      WHA              VCH              VCD              VCA             Bb1X2      
 Min.   : 1.170   Min.   : 1.040   Min.   : 3.000   Min.   : 1.180   Min.   : 3.00  
 1st Qu.: 2.600   1st Qu.: 1.650   1st Qu.: 3.400   1st Qu.: 2.630   1st Qu.:35.00  
 Median : 3.550   Median : 2.100   Median : 3.700   Median : 3.700   Median :37.00  
 Mean   : 5.041   Mean   : 2.762   Mean   : 4.416   Mean   : 5.472   Mean   :37.71  
 3rd Qu.: 5.500   3rd Qu.: 2.800   3rd Qu.: 4.400   3rd Qu.: 5.750   3rd Qu.:40.00  
 Max.   :26.000   Max.   :15.000   Max.   :17.000   Max.   :36.000   Max.   :43.00  
                                                                                    
     BbMxH            BbAvH            BbMxD            BbAvD            BbMxA       
 Min.   : 1.080   Min.   : 1.050   Min.   : 3.110   Min.   : 2.940   Min.   : 1.210  
 1st Qu.: 1.700   1st Qu.: 1.640   1st Qu.: 3.478   1st Qu.: 3.328   1st Qu.: 2.728  
 Median : 2.200   Median : 2.090   Median : 3.750   Median : 3.570   Median : 3.920  
 Mean   : 2.966   Mean   : 2.743   Mean   : 4.636   Mean   : 4.261   Mean   : 6.107  
 3rd Qu.: 2.882   3rd Qu.: 2.765   3rd Qu.: 4.553   3rd Qu.: 4.272   3rd Qu.: 6.105  
 Max.   :19.650   Max.   :16.300   Max.   :20.380   Max.   :15.320   Max.   :67.000  
                                                                                     
     BbAvA             BbOU          BbMx.2.5        BbAv.2.5       BbMx.2.5.1   
 Min.   : 1.170   Min.   : 3.00   Min.   :1.130   Min.   :1.120   Min.   :1.470  
 1st Qu.: 2.607   1st Qu.:31.75   1st Qu.:1.667   1st Qu.:1.617   1st Qu.:1.780  
 Median : 3.665   Median :34.00   Median :1.960   Median :1.880   Median :2.000  
 Mean   : 5.190   Mean   :34.06   Mean   :1.950   Mean   :1.872   Mean   :2.284  
 3rd Qu.: 5.543   3rd Qu.:37.00   3rd Qu.:2.203   3rd Qu.:2.120   3rd Qu.:2.402  
 Max.   :33.420   Max.   :42.00   Max.   :3.080   Max.   :2.850   Max.   :7.000  
                                                                                 
   BbAv.2.5.1         BbAH           BbAHh            BbMxAHH         BbAvAHH     
 Min.   :1.410   Min.   : 1.00   Min.   :-3.2500   Min.   :1.610   Min.   :1.580  
 1st Qu.:1.718   1st Qu.:17.00   1st Qu.:-0.7500   1st Qu.:1.890   1st Qu.:1.840  
 Median :1.920   Median :18.00   Median :-0.2500   Median :1.985   Median :1.930  
 Mean   :2.162   Mean   :18.16   Mean   :-0.4059   Mean   :1.988   Mean   :1.938  
 3rd Qu.:2.283   3rd Qu.:19.00   3rd Qu.: 0.0625   3rd Qu.:2.070   3rd Qu.:2.020  
 Max.   :5.970   Max.   :24.00   Max.   : 2.0000   Max.   :2.420   Max.   :2.340  
                                                                                  
    BbMxAHA         BbAvAHA           PSCH             PSCD             PSCA       
 Min.   :1.680   Min.   :1.630   Min.   : 1.060   Min.   : 2.930   Min.   : 1.160  
 1st Qu.:1.897   1st Qu.:1.850   1st Qu.: 1.640   1st Qu.: 3.410   1st Qu.: 2.590  
 Median :1.970   Median :1.930   Median : 2.120   Median : 3.700   Median : 3.850  
 Mean   :1.988   Mean   :1.937   Mean   : 2.839   Mean   : 4.508   Mean   : 5.695  
 3rd Qu.:2.080   3rd Qu.:2.030   3rd Qu.: 2.980   3rd Qu.: 4.560   3rd Qu.: 6.095  
 Max.   :2.520   Max.   :2.440   Max.   :18.700   Max.   :18.500   Max.   :46.000  
                                 NA's   :1        NA's   :1        NA's   :1     
```
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


#######Calculo estadistico de prueba para una muestra grande.########
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

