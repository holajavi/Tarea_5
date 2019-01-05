#Usando la librer�a rvest

install.packages('rvest')
library('rvest')

#Iniciando la variable archivo con el nombre de mi p�gina
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

#Pasando todas las palabras a min�sculas
splitEspacioNoticia<-tolower(splitEspacioNoticia)

#Contando palabras
unlistNoticias<-unlist(splitEspacioNoticia)
tablaPalabras<-table(unlistNoticias)

#Pasando la informaci�n
dfPalabraNoticia <- as.data.frame(tablaPalabras)
