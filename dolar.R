# Limpiamos el entorno.
rm(list = ls(all.names = TRUE))
gc()

# Cargamos los datos.
original <- read.csv("Consulta_20210115-212725028-truncado.csv", header = F)

# Vemos algunos datos.
head(original)

n <- length(original$V1) 
promedios <- numeric()
fechas <- character()
fechas_teorica <- character()
suma <- 0
contador <- 0
mes <- 8
year <- 1976
for (i in 1:n) {
  suma <- suma + original$V2[i]
  contador <- contador + 1
  if ((i == n) | (months(as.Date(original$V1[i])) != months(as.Date(original$V1[i+1])))) {
    promedios <- append(promedios, suma/contador)
    suma <- 0
    contador <- 0
    mes <- (mes%%12) + 1
    if(mes == 1) {
      year <- year + 1 
    }
    fechas <- append(fechas, paste(year, mes, sep = "-"))
    fechas_teorica <- append(fechas_teorica, as.Date(original$V1[i],format="%d/%m/%Y"))
  }
}

nuevos_datos <- data.frame(fechas, fechas_teorica, promedios)
series <- ts(promedios, start = c(1976,9), frequency = 12)
plot(series)
