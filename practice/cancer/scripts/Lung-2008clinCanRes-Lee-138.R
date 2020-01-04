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
dict_gpl <- t2[!grepl("///",ENTREZ_GENE_ID)][, .(probe=ID, geneid=ENTREZ_GENE_ID, symbol=`Gene Symbol`,des=`Gene Title`)]
dict_gpl

#2. DOWNLOAD expression data online
desdir <- "e:/data/target/paper1/LeeLung-GSE8894"; dir.create(desdir)
gset <- getGEO("GSE8894", GSEMatrix =TRUE, AnnotGPL=TRUE,
               destdir = desdir )

gset[[1]]@experimentData
index=gset[[1]]@annotation
# platformDB = paste0(platformMap$bioc_package[grep(index,platformMap$gpl)],".db")

myMatrix <- gset[[1]]@assayData$exprs
myPDfile <- pData(phenoData(gset[[1]]))

##############！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！#####################

#3. Get clinical data information needed in survival analysis 
clin_dt <- data.table(myPDfile)
clin_dt[, symbol:=rownames(myPDfile)]
clin_dt$geo_accession
colnames(clin_dt)
des <- data.table(do.call(rbind, strsplit(t(clin_dt[,"characteristics_ch1"]),"; ")))
info <- clin_dt[, .(surv_month =`recurrence free survival time (month):ch1`,
                status = `status (1=recurrence, 0=non-recurrence):ch1`,
                gender=`gender:ch1`) ]
sample_map <- data.table(sample=clin_dt$geo_accession,
                         info[, .(gender, RFS.time=as.numeric(surv_month), RFS=as.numeric(status) ) ] )


# the survival in this dataset is recurrence free survival time
sample_map[, RFS.time:=RFS.time/12]

#4. Merge expression files
# boxplot(myMatrix[,6:16])
expr_dt <- data.table(probe=rownames(myMatrix), myMatrix) ## log2 transformation of the MAS5 value
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
save(all_shot_gene, clin_dt, file = "Lee-LUAD-138.Rdata")

######################################
###    ANALYSIS FOR Hatzis data    ###
######################################
load(file =  "e:/data/target/paper1/Lee-LUAD-138.Rdata")
all_shot_gene[1:5,1:5]

library(org.Hs.eg.db)
id2acc=toTable(org.Hs.egACCNUM)
id2symbol=data.table(toTable(org.Hs.egSYMBOL))
targetid <- id2symbol[symbol %in% c("C5AR2", "MME"), ]
all_shot_gene[geneid %in% targetid$gene_id]
all_shot_gene[geneid==79969]
#nrDEG_des=merge(nrDEG,id2symbol,by.x='ID', by.y='gene_id')
# 4311;27202;79969(C6orf134)
t <- melt(all_shot_gene[symbol %in% c("C5AR2", "MME","ATAT1"), -c("geneid")],
          id.vars = c("symbol"), variable.name = "sample",
          value.name = "norm_fpkm")
t2 <- dcast(t, sample~symbol, value.var = "norm_fpkm")
mark_expr <- merge(clin_dt, t2, by="sample")
boxplot(mark_expr[,4:6])

library(survival)
library(survminer)

#find better cutoff value using maximally selected rank statistics
surv_data <- mark_expr

mdt_clin_5y <- surv_data[RFS.time <=5 & RFS.time >= 0.1]#
mdt_clin_10y <- surv_data[RFS.time <=10 & RFS.time >= 0.1]#
summary(surv_data[,RFS.time])

# define the cutoff data table
#define the survival time type, here we only got RFS
cutoff_surv <- function(mdt_clin=mdt_clin_10y)
{
  # mdt_clin=mdt_clin_10y
  res.cut.RFS <- surv_cutpoint(mdt_clin, time = "RFS.time", event = "RFS", variables = c("C5AR2","MME"))
  # res.cut.RFS <- surv_cutpoint(mdt_clin, time = "RFS.time", event = "RFS", variables = "ATAT1")
  summary(res.cut.RFS)
  #use the optimized cutoff to stratify samples
  res.cat <- data.table(surv_categorize(res.cut.RFS))
  res.cat[, sample:=mdt_clin$sample]
  head(res.cat)
  res.cat[(C5AR2!="high" | MME!="high"), mark_group:="high-"]
  res.cat[C5AR2=="high" & MME=="high", mark_group:="high+"]
  # res.cat[C5AR2=="low" & MME=="low", mark_group:="low"]
  res.cat[,.N, by=mark_group]
  
  #merge into final survival data, create survivial object
  mdt_clin[, mark_group_RFS:= res.cat$mark_group]
  
  #calculate the difference
  return(mdt_clin)
}

surv_data_10y <- cutoff_surv(mdt_clin_10y)
surv_data_5y <- cutoff_surv(mdt_clin_5y)

## plot the survival plot and p value
sfit_10y = survfit(Surv(RFS.time, RFS) ~ mark_group_RFS, data=surv_data_10y)
sfit_5y = survfit(Surv(RFS.time, RFS) ~ mark_group_RFS, data=surv_data_5y)
# sfit_10y = survfit(Surv(RFS.time, RFS) ~ ATAT1, data=surv_data_10y)

ylab1 = "Metastais Free Survival\n 10 years"
ylab2 = "Metastais Free Survival\n 5 years"

p_os_10=ggsurvplot(sfit_10y, data = surv_data_10y,
                   pval =TRUE,pval.method = T,
                   xlab ="Time in years",
                   ylab =ylab1,
                   conf.int=F,risk.table=T,
                   # surv.median.line="hv",
                   # legend="none",
                   font.x = c(18, "plain", "black"),
                   font.y = c(18, "plain", "black"),
                   font.tickslab = c(18, "plain", "black"),
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
png(filename = "figs/surv-leelung.png", width=420, height = 720)
p_surv_lung
dev.off()




###########################################Test for ATAT1################################



cutoff_surv <- function(mdt_clin=mdt_clin_10y, genename="ATAT1")
{
  mdt_clin=mdt_clin_10y
  res.cut.RFS <- surv_cutpoint(mdt_clin, time = "RFS.time", event = "RFS", variables = genename)
  summary(res.cut.RFS)
  #use the optimized cutoff to stratify samples
  res.cat.RFS <- data.table(surv_categorize(res.cut.RFS))[, get(eval(genename))]
  #merge into final survival data, create survivial object
  mdt_clin[, mark_group_RFS:= res.cat.RFS]
  mdt_clin[,.N, by=.(mark_group_RFS)]
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
                  legend.lab=c("ATAT1-high","ATAT1-low"),
                  palette = c("#00AFBB", "#FC4E07"),
                  ggtheme =theme_light())
  p_os
}

ylab1 = "Replapse Free Survival\n 10 years"
ylab2 = "Replapse Free Survival\n 5 years"
mdt_clin_5y <- surv_data[RFS.time <=5 & RFS.time >= 0]#
mdt_clin_10y <- surv_data[RFS.time <=10 & RFS.time >= 0]#
surv_data_10y <- cutoff_surv(mdt_clin_10y, genename="ATAT1")
surv_data_5y <- cutoff_surv(mdt_clin_5y, genename="ATAT1")
sfit_10y = survfit(Surv(RFS.time, RFS) ~ mark_group_RFS, data=surv_data_10y)
sfit_5y = survfit(Surv(RFS.time, RFS) ~ mark_group_RFS, data=surv_data_5y)
p_os10 <- surv_plot(sfit=sfit_10y,  data = surv_data_10y,  ylab =ylab1)
p_os5 <- surv_plot(sfit=sfit_5y,  data = surv_data_5y,  ylab =ylab2)

library(cowplot)
p_os <- plot_grid(p_os10$plot, p_os10$table, 
                  p_os5$plot,p_os5$table,
                  nrow = 4, align = "v", rel_heights = c(3,1.25))
p_os
png(filename = "figs/atat1-survRFS-leelung.png", width=420, height = 720)
p_os
dev.off()

