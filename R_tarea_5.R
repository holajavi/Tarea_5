#Usando la librería rvest

#install.packages('rvest')
library('rvest')

#Iniciando la variable archivo con el nombre de mi página
archivo<-'ArteJavi.html'

#Leyendo el HTML del archivo
webpage<-read_html(archivo)

#Extrayendo contenido en la clase justificado
contenidoWebNoticia <- html_nodes(webpage,'.justificado')

#Pasando la info a texto
textoNoticia <- html_text(contenidoWebNoticia)

#Pasando la info a texto
print(textoNoticia)

#Eliminando los \n, comillas ("), punto(.), y comas (,) del texto
textoNoticia<-gsub("\n","",textoNoticia)
textoNoticia<-gsub("\"","",textoNoticia)
textoNoticia<-gsub("[.]","",textoNoticia)
textoNoticia<-gsub(",","",textoNoticia)

#Separando las palabras por espacio
splitEspacioNoticia <- strsplit(textoNoticia," ")[[1]]

#Pasando todas las palabras a minúsculas
splitEspacioNoticia<-tolower(splitEspacioNoticia)

#Contando palabras
unlistNoticias<-unlist(splitEspacioNoticia)
tablaPalabras<-table(unlistNoticias)

#Pasando la información
dfPalabraNoticia <- as.data.frame(tablaPalabras)

#Pista 
textoCompleto <-""
for(i in 1:length(textoNoticia)){
  textoCompleto <-paste(textoCompleto," ",textoNoticia[i]) 
}

textoCompleto

#Pasando la info a un data frame
dfPalabrasNoticia <- as.data.frame(tablaPalabras)
dfPalabrasNoticia

#Almacenamiento de información en CVS
write.csv(dfPalabrasNoticia, file="PalabrasNoticia.cvs")

#o en un txt
write.table(dfPalabrasNoticia, file="PalabrasNoticia.txt")


#####Exraccion de informacion de la tabla###

#Extrayendo el contenido de la tabla a traves de tag
tablaProductos <- html_nodes(webpage,".productos")
contenedorTablas <- html_nodes(tablaProductos, "table")


#ejemplo


#Extrayendo los elementos de la tabla1
tabla1 <- html_table(contenedorTablas[1][[1]])

#Viendo el contenido de la posicion 1,2 de la tabla1 
print(tabla1[1,2])

#Extrayendo los elementos de la tabla2
tabla2 <- html_table(contenedorTablas[2][[1]])

#Viendo el contenido de la posición 1,2 de la tabla2
print(tabla2[1,2])


# Limpiando $ comas y cambios de puntos por coma
tabla1$PRECIO <- gsub("\\$","",tabla1$PRECIO)
tabla1$PRECIO <- gsub("[.]","",tabla1$PRECIO)
tabla1$PRECIO <- as.numeric(gsub(",",".",tabla1$PRECIO))

tabla2$PRECIO <- gsub("\\$","",tabla2$PRECIO)
tabla2$PRECIO <- gsub("[.]","",tabla2$PRECIO)
tabla2$PREICO <- as.numeric(gsub(",",".",tabla2$PRECIO))


################### Graficando los productos
library('ggplot2')

# GrÃ¡fico Barra por producto concatenado con supermercado,
# respecto al costo
tabla1 %>%
  ggplot() +
  aes(x = PRODUCTO, y = PRECIO) +
  geom_bar(stat="identity")


tabla2 %>%
  ggplot() +
  aes(x = PRODUCTO, y = PRECIO) +
  geom_bar(stat="identity")

