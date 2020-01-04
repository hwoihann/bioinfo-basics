setwd("e:/data/target/paper1/")
library(data.table)

#####
#Cancer Cell Line Encyclopedia (CCLE): a compilation of gene expression, chromosomal copy number, and massively parallel sequencing data from 947 human cancer cell lines.
#Affymetrix Human Genome U133 Plus 2.0 Array [Brainarray Version 15.0.0, HGU133Plus2_Hs_ENTREZG]
#
#
#####

# "E:/data/bioinfo-basics/practice/cancer/scripts"
library(GEOquery)
library(data.table)
options(stringsAsFactors = F)
ccleFromGEO <- getGEO("GSE36133")
annotBlock1 <- data.table(pData(phenoData(ccleFromGEO[[1]])))
dim(annotBlock1)

exprSet <- exprs(ccleFromGEO[[1]]) 
exprSet <- data.table(exprSet,keep.rownames = T)
exprSet <- exprSet[, probe:=rn][,-"rn"]; exprSet[1:5,1:5]
dim(exprSet) #18926个基因，列名是917个细胞系
ccle_info <- annotBlock1[, .(celline=title, geo_accession,
                histo1=`histology:ch1`, 
                histo2=gsub("histology subtype1: ", "", `characteristics_ch1.2`),
                site=`primary site:ch1`)]
setkeyv(ccle_info, "celline")
ccle_info["HCC1569"]
ccleFromGEO[[1]]@experimentData
index=ccleFromGEO[[1]]@annotation;index

gpl <- getGEO(index,destdir = "e:/data/target/paper1/platform")
names(Meta(gpl))
names(gpl@header)
t <- (gpl@dataTable)
colnames(t@columns)
colnames((t@table))
t2 <- data.table(t@table)
dict_gpl <- t2[!grepl("///",ORF)][, .(probe=ID,geneid=ORF, Description)]
dict_gpl


library(org.Hs.eg.db)
id2acc=toTable(org.Hs.egACCNUM)
id2symbol=data.table(toTable(org.Hs.egSYMBOL))
id2symbol[, gene_id:=as.integer(gene_id)]
targetid <- id2symbol[symbol %in% c("C5AR2", "MME", "ATAT1"), ]

dict_gpl <- merge(dict_gpl, id2symbol,by.x="geneid",by.y="gene_id")

#4. Merge expression files
# boxplot(myMatrix[,6:16])
expr_dt <- exprSet  ## log2 transformation if needed

## merge dictionary and expression table
all_dt <- merge(dict_gpl, expr_dt,  by="probe")
boxplot(all_dt[, 8:28])
all_long <- melt(all_dt[, !"Description"], id.vars =c("probe","geneid","symbol"),
                 variable.name = "sample", value.name = "RMA_expr" )
all_long_gene <- all_long[, .(norm_expr=mean(RMA_expr)), by=.(geneid, symbol, sample)]
all_long_gene <-  merge(ccle_info,all_long_gene, by.y="sample", by.x="geo_accession")


# save(all_long_gene,ccle_info, dict_gpl, file = "CCLE-191104.Rdata")

library(ggplot2)
gdt <- all_long_gene[symbol=="ATAT1"]
gdt[,.N, by=.(histo2,site)]
gdt[,.N, by=site]

ggplot(gdt, aes(x=site, y=norm_expr)) +
  geom_boxplot(aes(fill=site))  + theme_bw() + 
  theme(axis.text.x = element_text(size=12, angle = 45, hjust = 1),
        legend.position='none')+ xlab("") +
  ggtitle("MEC17 expression in human cancer cell lines")
##1062 cell lines representing 37 distinct cancer types, glioma cell lines express the highest levels of STK17A


library(data.table)
atat_mut <- fread("e:/data/target/data_portal/atat1/ATAT1_CCLE_mutation.csv")
mut <- atat_mut[, .(celline=`Cell Line`, 
             variant=`Variant Classification`, 
             conservation=`Variant Annotation`,
             Type=`Variant Type`,
             Protein=`Protein Change`)]

ccle_info[grepl("NCIH508",celline)]

atat_CNV <- fread("e:/data/target/data_portal/atat1/ATAT1_copynumber.csv")
info <- atat_CNV[,.(celline=`Cell Line Name`, des=`Primary Disease`)]


atat_mut_celline <- merge(mut,info, by="celline")[order(des)]
write.table(atat_mut_celline, sep=",", quote = F, row.names = F,
            file="e:/data/target/data_portal/atat1/atat_mut_celline.csv")


