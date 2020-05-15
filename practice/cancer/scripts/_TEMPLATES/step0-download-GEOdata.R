setwd("e:/data/target/paper1/")
library(data.table)

######################
# PaperName: Bild Nature 2006 Jan 19;439(7074):353-7. PMID: 16273092
# GEONum: GSE3141
# Expression value type: MAS5-calculated signal intensity
######################

library(GEOquery)


#1. Download probe mapping files
gpl <- getGEO("GPL570",destdir = "e:/data/target/paper1/platform")
names(Meta(gpl))
names(gpl@header)

t <- (gpl@dataTable)
colnames(t@columns)
colnames((t@table))
t2 <- data.table(t@table)
dict_gpl <- t2[!grepl("///",ENTREZ_GENE_ID)][, .(probe=ID,geneid=ENTREZ_GENE_ID, symbol=`Gene Symbol`,des=`Gene Title`)]
dict_gpl # get dict_gpl 
##############！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！#####################


#2. DOWNLOAD expression data
## method1, online
desdir <- "e:/data/target/paper1/Bild-GSE3141";dir.create(desdir)
gset <- getGEO("GSE3141", GSEMatrix =TRUE, AnnotGPL=TRUE,
               destdir = desdir )

# gset[[1]]@experimentData
# index=gset[[1]]@annotation
# platformDB = paste0(platformMap$bioc_package[grep(index,platformMap$gpl)],".db")

myMatrix <- gset[[1]]@assayData$exprs
myPDfile <- pData(phenoData(gset[[1]]))

## method2, offline
library(limma)
gset2 <- getGEO(filename=paste0(desdir,"/GSE3141_series_matrix.txt.gz"))
myMatrix <- exprs(gset2) #gset2@assayData$exprs
norm_exprSet=normalizeBetweenArrays(myMatrix)
myMatrix[1:5,1:5]
# boxplot(myMatrix[,1:15])
# boxplot(norm_exprSet[,1:15])
expr_dt  <- data.table(norm_exprSet)
expr_dt[, probe:=rownames(norm_exprSet)]
myPDfile <- pData(phenoData(gset2))
##############！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！#####################

#3. Get clinical data information needed in survival analysis 
Bild_clin_dt <- data.table(myPDfile)
Bild_clin_dt[, symbol:=rownames(myPDfile)]
Bild_clin_dt$geo_accession
des <- data.table(do.call(rbind, strsplit(t(Bild_clin_dt[,"characteristics_ch1"]),"; ")))
info <- des[, .(surv_month = gsub("Surv\\(months\\): ","", V2, perl=TRUE), 
                status = gsub("STATUS\\(0=alive, 1=dead\\):","", V3, perl=TRUE)) ]
sample_map <- data.table(sample=Bild_clin_dt$geo_accession,
                         info[, .(OFS.time=as.numeric(surv_month), OFS=as.numeric(status) ) ] )


#4. Merge expression files
expr_dt <- data.table(probe=rownames(myMatrix), log2(myMatrix)) ## log2 transformation of the MAS5 value
## merge dictionary and expression table
all_dt <- merge(dict_gpl, expr_dt,  by="probe")
all_dt <- all_dt[geneid!=""]
boxplot(all_dt[, 8:28])
all_long <- melt(all_dt, id.vars =c("geneid", "symbol", "des","probe"),
                 variable.name = "sample", value.name = "mas5_expr" )
# all_long <- merge(sample_map, all_long, by="sample")
all_long_gene <- all_long[, .(norm_epxr=mean(mas5_expr)), by=.(geneid, symbol, des,sample)]
all_shot_gene <- dcast(all_long_gene, symbol+geneid~sample, value.var = "norm_epxr", fun.aggregate = mean)


expr_dt[1:5,1:5]
all_dt[1:5,1:5]
all_dt <- merge(dict_gpl, expr_dt,  by="probe")

long_dt <- melt(all_dt, id.vars =c("probe", "geneid", "symbol", "des"), variable.name = "sample", value.name = "norm_expr" )
long_dt <- long_dt[!(symbol=="")]
geneave_dt <- long_dt[, .(norm_epxr=mean(norm_expr)), by=.(geneid, symbol, des, sample)]
shot_dt <- dcast(geneave_dt, symbol+geneid+des~sample, value.var = "norm_epxr")
shot_dt[1:8,1:8]


Bild_expr_dt <- shot_dt
save(Bild_expr_dt, Bild_clin_dt, file = "Bild-LUAD-111.Rdata")

