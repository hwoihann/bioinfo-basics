setwd("e:/data/target/paper1/")
library(data.table)

######################
# Paper2: Bild Nature 2006 Jan 19;439(7074):353-7. PMID: 16273092
# GEONum: GSE3141
# Expression value type: MAS5-calculated signal intensity
######################

library(GEOquery)
#Download probe mapping files
gpl <- getGEO("GPL570",destdir = "e:/data/target/paper1/platform")
names(Meta(gpl))
names(gpl@header)

t <- (gpl@dataTable)
colnames(t@columns)
colnames((t@table))
t2 <- data.table(t@table)
dict_gpl <- t2[!grepl("///",ENTREZ_GENE_ID)][, .(probe=ID,geneid=ENTREZ_GENE_ID, symbol=`Gene Symbol`,des=`Gene Title`)]
dict_gpl

#2. DOWNLOAD expression data online
desdir <- "e:/data/target/paper1/Bild-GSE3141";dir.create(desdir)
gset <- getGEO("GSE3141", GSEMatrix =TRUE, AnnotGPL=TRUE,
               destdir = desdir )

# gset[[1]]@experimentData
# index=gset[[1]]@annotation
# platformDB = paste0(platformMap$bioc_package[grep(index,platformMap$gpl)],".db")

myMatrix <- gset[[1]]@assayData$exprs
myPDfile <- pData(phenoData(gset[[1]]))

##############！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！#####################

#3. Get clinical data information needed in survival analysis 
Bild_clin_dt <- data.table(myPDfile)
Bild_clin_dt[, symbol:=rownames(myPDfile)]
Bild_clin_dt$geo_accession
des <- data.table(do.call(rbind, strsplit(t(Bild_clin_dt[,"characteristics_ch1"]),"; ")))
info <- des[, .(surv_month = gsub("Surv\\(months\\): ","", V2, perl=TRUE), 
                status = gsub("STATUS\\(0=alive, 1=dead\\):","", V3, perl=TRUE)) ]
sample_map <- data.table(sample=Bild_clin_dt$geo_accession,
                         info[, .(OS.time=as.numeric(surv_month), OS=as.numeric(status) ) ] )
sample_map[, OS.time:=OS.time/12]

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

clin_dt <- sample_map
save(all_shot_gene, clin_dt, file = "Bild-LUAD-111.Rdata")



######################################
###    ANALYSIS FOR Hatzis data    ###
######################################
load(file = "e:/data/target/paper1/Bild-LUAD-111.Rdata")
Bild_expr_dt[1:5,1:5]

library(org.Hs.eg.db)
id2acc=toTable(org.Hs.egACCNUM)
id2symbol=data.table(toTable(org.Hs.egSYMBOL))
targetid <- id2symbol[symbol %in% c("C5AR2", "MME"), ]
all_shot_gene[geneid%in% targetid$gene_id]
#nrDEG_des=merge(nrDEG,id2symbol,by.x='ID', by.y='gene_id')
# 4311;27202
t <- melt(all_shot_gene[symbol %in% c("C5AR2", "MME","ATAT1"), -c("geneid")],
          id.vars = c("symbol"),variable.name = "sample",
          value.name = "norm_fpkm")
t2 <- dcast(t, sample~symbol, value.var = "norm_fpkm")
mark_expr <- merge(clin_dt, t2, by="sample")

library(survival)
library(survminer)

#find better cutoff value using maximally selected rank statistics
surv_data <- mark_expr
mdt_clin_5y <- surv_data[OS.time <=5 & OS.time >= 0.5]#
mdt_clin_10y <- surv_data[OS.time <=10 & OS.time >= 0.5]#
summary(surv_data[,OS.time])

# define the cutoff data table
#define the survival time type, here we only got OS
cutoff_surv <- function(mdt_clin=mdt_clin_10y)
{
  # mdt_clin=mdt_clin_10y
  res.cut.OS <- surv_cutpoint(mdt_clin, time = "OS.time", event = "OS", variables = c("C5AR2","MME"))
  summary(res.cut.OS)
  #use the optimized cutoff to stratify samples
  res.cat <- data.table(surv_categorize(res.cut.OS))
  res.cat[, sample:=mdt_clin$sample]
  head(res.cat)
  res.cat[(C5AR2!="high" | MME!="high"), mark_group:="high-"]
  res.cat[C5AR2=="high" & MME=="high", mark_group:="high+"]
  res.cat[,.N, by=mark_group]
  
  #merge into final survival data, create survivial object
  mdt_clin[, mark_group_OS:= res.cat$mark_group]
  
  #calculate the difference
  return(mdt_clin)
}

surv_data_10y <- cutoff_surv(mdt_clin_10y)
surv_data_5y <- cutoff_surv(mdt_clin_5y)

## plot the survival plot and p value
sfit_10y = survfit(Surv(OS.time, OS) ~ mark_group_OS, data=surv_data_10y)
sfit_5y = survfit(Surv(OS.time, OS) ~ mark_group_OS, data=surv_data_5y)

ylab1 = "Metastais Free Survival\n 10 years"
ylab2 = "Metastais Free Survival\n 5 years"

p_os_10=ggsurvplot(sfit_10y, data = surv_data_10y,
                   pval =TRUE,pval.method = T,
                   xlab ="Time in years",
                   ylab =ylab1,
                   conf.int=F, risk.table=T,
                   # surv.median.line="",
                   font.x = c(16, "plain", "black"),
                   font.y = c(16, "plain", "black"),
                   font.tickslab = c(16, "plain", "black"),
                   legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                   palette = c( "#00AFBB","#FC4E07"),
                   ggtheme =theme_light())
print(p_os_10)


p_os_5=ggsurvplot(sfit_5y, data = surv_data_5y,
                  pval =TRUE,pval.method = T,
                  xlab ="Time in years",
                  ylab =ylab2,
                  conf.int=F, risk.table=T,
                  # surv.median.line="",
                  font.x = c(16, "plain", "black"),
                  font.y = c(16, "plain", "black"),
                  font.tickslab = c(16, "plain", "black"),
                  legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                  palette = c( "#00AFBB","#FC4E07"),
                  ggtheme =theme_light())
print(p_os_5)

library(cowplot)
p_surv_lung <- plot_grid(p_os_10$plot, p_os_10$table, 
                         p_os_5$plot,p_os_5$table,
                         nrow = 4, align = "v", rel_heights = c(3,1.25))

p_surv_lung
png(filename = "E:/data/target/paper1/figs/surv-bildLung.png", width=420, height = 720)
p_surv_lung
dev.off()



###########################################Test for ATAT1################################



cutoff_surv <- function(mdt_clin=mdt_clin_10y,genename="ATAT1")
{
  # mdt_clin=mdt_clin_10y
  res.cut.OS <- surv_cutpoint(mdt_clin, time = "OS.time", event = "OS", variables = genename)
  summary(res.cut.OS)
  #use the optimized cutoff to stratify samples
  res.cat.OS <- data.table(surv_categorize(res.cut.OS))[, get(eval(genename))]
  #merge into final survival data, create survivial object
  mdt_clin[, mark_group_OS:= res.cat.OS]
  mdt_clin[,.N, by=.(mark_group_OS)]
  #calculate the difference
  return(mdt_clin)
}



## plot the survival plot and p value
surv_plot <- function(sfit=sfit_10y,  data = surv_data_10y,  ylab =ylab1) {
  p_os=ggsurvplot(sfit, data = data,
                  pval =TRUE,pval.method = T,
                  xlab ="Time in years",
                  ylab =ylab,
                  conf.int=F, risk.table=T,
                  # surv.median.line="",
                  font.x = c(16, "plain", "black"),
                  font.y = c(16, "plain", "black"),
                  font.tickslab = c(16, "plain", "black"),
                  # legend.lab=c("ATAT1-high","ATAT1-low"),
                  # palette = c("#00AFBB", "#FC4E07"),
                  ggtheme =theme_light())
  p_os
}

ylab1 = "Overall Survival\n 10 years"
ylab2 = "Overall Survival\n 5 years"
mdt_clin_5y <- surv_data[OS.time <=5 & OS.time >= 0]#
mdt_clin_10y <- surv_data[OS.time <=10 & OS.time >= 0]#
surv_data_10y <- cutoff_surv(mdt_clin_10y, genename="ATAT1")
surv_data_5y <- cutoff_surv(mdt_clin_5y, genename="ATAT1")
sfit_10y = survfit(Surv(OS.time, OS) ~ mark_group_OS, data=surv_data_10y)
sfit_5y = survfit(Surv(OS.time, OS) ~ mark_group_OS, data=surv_data_5y)
p_os10 <- surv_plot(sfit=sfit_10y,  data = surv_data_10y,  ylab =ylab1)
p_os5 <- surv_plot(sfit=sfit_5y,  data = surv_data_5y,  ylab =ylab2)

library(cowplot)
p_os <- plot_grid(p_os10$plot, p_os10$table, 
                  p_os5$plot,p_os5$table,
                  nrow = 4, align = "v", rel_heights = c(3,1.25))
p_os
png(filename = "figs/atat1-survOS-bildBreast.png", width=420, height = 720)
p_os
dev.off()
