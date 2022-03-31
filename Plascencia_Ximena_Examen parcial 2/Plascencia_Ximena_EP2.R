library(BiocGenerics)
library(Biobase)
library(IRanges)

#Manipulación de datos

#Generamos un objeto de clase Iranges

x = IRanges(start=c(11,35,40), end=c(20,50,63))

x

#Extracción de información básica

start(x) # Todos los inicios
end(x)   # Todos los finales
width(x) # Ancho de cada rango
range(x) # Rango total de todos

### Más funciones

coverage(x) # La suma de la cobertura en cada posición
reduce(x)   # Une los rangos que estan encimado
exons = reduce(x)

reads = IRanges(start=c(1,21,30,50,80), width=20)

reads


countOverlaps(exons, reads)


#Anotación del genoma
#Cargamos y descargamos las librerias necesarias
library (S4Vectors)
library(stats4)
install.packages("rtracklayer")
library(rtracklayer)
library(GenomicRanges)
library(GenomeInfoDb)

#Cargamos la base de datos
load("human.Rdata")
human


#Revisamos los datos
seqnames(human)
ranges(human)
strand(human)
mcols(human)

#Manipulación de datos, seleccionamos unicamente gene_biotype y observamos sus dtaos

table(mcols(human)$gene_biotype)

#modo de selección de columnas deseadas
mcols(human) = mcols(human)[,c("source","gene_id","gene_name","gene_biotype")]

mcols(human)

#Selección de datos con which, el cual nos permite seleccionar de 
#bases de datos, los datos deseados, en este caso 
#which (basededatos$gene_biotype (aqui estan los datos del miRNA) == (solo seleccionar miRNA))

miRNA <- which(human$gene_biotype == "miRNA")

miRNA


#en este caso usaremos subset ya que tenemos que entrar a un nuevo componente del objeto
#el cual es strans, de strand del objeto human, seleccionamos las cadenas negativas
#que tienen el signo "-"
cadmeg <- subset (human, strand (human) == "-")
cadneg #cargamos el objeto

#Secuencias mapeadas
install.packages("Rmsatools")
library(Rsamtools) #cargamos la libreria
library(Biostrings)
library(XVector)
#seleccion de datos y parametros

what = c("rname", "strand", "pos", "qwidth")
param = ScanBamParam(what=what)
bam = scanBam("human_mapped_small.bam", param=param) #leer el archivo baam

class(bam)

lapply(bam, names)


#con GRanges hacemos un archivo con los datos que queremos

mapGR = GRanges(
  seqnames = bam[[1]]$rname,
  ranges   = IRanges(start=bam[[1]]$pos, width=bam[[1]]$qwidth),
  strand   = bam[[1]]$strand
)

mapGR

#Seleccionamos las columnas deseadas

mcols(human)$counts = countOverlaps(human, mapGR)

mcols(human)


#agregamos los valores a los datos de biotype

typeCounts = aggregate(mcols(human)$counts, by=list("biotype"=mcols(human)$gene_biotype), sum)

typeCounts

# agregamos datos a un solo gene o vafrios dependiendo de lo que quereis

geneCounts = aggregate(mcols(human)$counts, by=list("id"=mcols(human)$gene_name), sum)

head(geneCounts)

#hacemos un plot que nos mencione la cantudad de datis que tenemos por tipo de dato que recolectamos

minCount = 40000
typeCountsHigh = typeCounts[typeCounts$x > minCount,]
typeCountsHigh = typeCountsHigh[order(typeCountsHigh$x),]
typeCountsHigh = rbind(data.frame("biotype"="other",
                                  "x"=sum(typeCounts$x[typeCounts$x <= minCount])),
                       typeCountsHigh)

pie(typeCountsHigh$x, labels=typeCountsHigh$biotype, col=rev(rainbow(nrow(typeCountsHigh))),
    main="Number of aligned reads per biotype")