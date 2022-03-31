#1. La tabla alojada en el objeto resultados.RDS (anexo a esta entrada) tiene identificadores de  genes y  contrastes de medidas de expresión así como p-values  para un experimento de microarreglos en donde se quiere comparar una condición A vs WT. El contraste realizado es A-WT. Escribe un programa en R que:

#Cargamos las librerias que vamos a usar
library(BiocGenerics) 
library(Biobase)
library(limma)
library(affy)

#Lea la tabla.
tabla <- load("resultados.RDS")
tabla <- fit2
genes <- tabla$F.p.value

#(2%) Haga un boxplot de expresión.
library(viridis)
boxplot(genes, col=viridis)

#(2%) Grafique un PCA.
#(2%) Encuentre las sondas que se sobre expresan y sub expresan.
#(2%) Cuente cuántas sondas se sobre expresan y cuántas se sub expresan.
#(2%)Genera una figura de volcán manualmente, que incluya todas las sondas.
#(10%) Realiza un análisis de GO para las tres ontologías para los genes diferencialmente expresados. Genera gráficas y/o tablas de las categorías sobre o sub expresadas. A partir de este resultado elabora una hipótesis de lo que trata el experimento

#Discute tus resultados.