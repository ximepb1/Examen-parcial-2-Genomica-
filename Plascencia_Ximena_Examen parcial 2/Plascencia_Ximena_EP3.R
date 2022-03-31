library(BoolNet)

#Generamos un archivo de texto plano
red <- loadNetwork("Red.txt")
red

#1. ¿Cuántos atractores tiene esta red?
atractores<- getAttractors(red)
atractores
#plot de los atractores
atra <- plotAttractors(atractores)
#Hay un atractor con dos estado 
#un atractor con 6 estados

#2. ¿Cual es el estado más probable?
#es más probable que estén los 6 estados del atractor 2, ya que para 
#que este suceda se tiene que activar un solo gen y 
#de esta manera se conducen a los estados faltantes
#al contrario, si se activaran 2 genes, los estados terminarían en ese instante

#¿Hay atractores cíclicos?
#4. Dibuja los atractores.
plotStateGraph(atractores) 
#Sí, el atractor 2


