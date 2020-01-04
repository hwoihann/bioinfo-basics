


setwd("e:/data/target/paper1/")
library(data.table)


######################
# Paper2: HatizHatiz,
# GEONum: GSE25066
######################
library(GEOquery)


#Download probe mapping files
gpl96 <- getGEO("GPL96",destdir = "e:/data/target/paper1/platform")
names(Meta(gpl96))
names(gpl96@header)

t <- (gpl96@dataTable)
colnames(t@columns)
colnames((t@table))
t2 <- data.table(t@table)
dict_gpl96 <- t2[!grepl("///",ENTREZ_GENE_ID)][,.(probe=ID,geneid=ENTREZ_GENE_ID, symbol=`Gene Symbol`,des=`Gene Title`)]
dict_gpl96

#DOWNLOAD expression data
##method1, online
gset <- getGEO("GSE25066", GSEMatrix =TRUE, AnnotGPL=TRUE,
               destdir = "e:/data/target/paper1/Hatis-GSE25066" )
gset[[1]]@experimentData
index=gset[[1]]@annotation
platformDB = paste0(platformMap$bioc_package[grep(index,platformMap$gpl)],".db")


myMatrix <- gset[[1]]@assayData$exprs
myPDfile <- pData(phenoData(gset))

##method2, offline
library(limma)
gset2 <- getGEO(filename="e:/data/target/paper1/Hatis-GSE25066/GSE25066_series_matrix.txt.gz")
myMatrix <- exprs(gset2) #gset2@assayData$exprs
norm_exprSet=normalizeBetweenArrays(myMatrix)
myMatrix[1:5,1:5]
# boxplot(myMatrix[,1:15])
# boxplot(norm_exprSet[,1:15])
expr_dt  <- data.table(norm_exprSet)
expr_dt[, probe:=rownames(norm_exprSet)]

myPDfile <- pData(phenoData(gset2))
hatis_clin_dt <- data.table(myPDfile)
hatis_clin_dt[, symbol:=rownames(myPDfile)]
colnames(hatis_clin_dt)
hatis_clin_dt <- hatis_clin_dt[, .(sample=title,gsm=symbol,
              MFS=`dMFS_1_event_0_censored:ch1`, MFS.year=as.numeric(`dMFS_even_time_years:ch1`),
              stage=`clinical_t_stage:ch1`, ER=`er_status_ihc:ch1`, HER2=`her2_status:ch1`,
              grade=`grade:ch1`, cheomeSensitivity=`chemosensitivity_prediction:ch1`)]

#Merge expression files
expr_dt[1:5,1:5]
all_dt[1:5,1:5]
all_dt <- merge(dict_gpl96, expr_dt,  by="probe")

long_dt <- melt(all_dt, id.vars =c("probe", "geneid", "symbol", "des"), variable.name = "sample", value.name = "norm_expr" )
long_dt <- long_dt[!(symbol=="")]
geneave_dt <- long_dt[, .(norm_epxr=mean(norm_expr)), by=.(geneid, symbol, des, sample)]
shot_dt <- dcast(geneave_dt, symbol+geneid+des~sample, value.var = "norm_epxr")
shot_dt[1:8,1:8]

hatis_expr_dt <- shot_dt
save(hatis_expr_dt, hatis_clin_dt, file = "hatis-BRCA-501.Rdata")



######################################
###    ANALYSIS FOR Hatzis data    ###
######################################
load(file = "e:/data/target/paper1/hatis-BRCA-501.Rdata")
hatis_expr_dt[1:5,1:5]
summary(hatis_clin_dt$MFS.year)
summary(hatis_clin_dt$MFS)

library(org.Hs.eg.db)
id2acc=toTable(org.Hs.egACCNUM)
id2symbol=data.table(toTable(org.Hs.egSYMBOL))
id2symbol[symbol %in% c("C5AR2", "MME"),]
#nrDEG_des=merge(nrDEG,id2symbol,by.x='ID', by.y='gene_id')
# 4311;27202
t <- melt(hatis_expr_dt[symbol %in% c("C5AR2", "MME","ATAT1"), -c("des","geneid")],
                    id.vars = c("symbol"),variable.name = "sample",
                     value.name = "norm_fpkm")
t2 <- dcast(t, sample~symbol, value.var = "norm_fpkm")
mark_expr <- merge(hatis_clin_dt, t2, by.x="gsm", by.y="sample")

library(survival)
library(survminer)

#find better cutoff value using maximally selected rank statistics
surv_data <- mark_expr
surv_data[, MFS:=as.numeric(MFS)]


mdt_clin_5y <- surv_data[MFS.year <=5 & MFS.year >= 0.5]#
mdt_clin_10y <- surv_data[MFS.year <=10 &  MFS.year >= 0.5] ## &
summary(surv_data[,MFS.year])

# define the cutoff data table
#define the survival time type, here we only got MFS
cutoff_surv <- function(mdt_clin=mdt_clin_10y)
{
# mdt_clin=mdt_clin_10y
res.cut.mfs <- surv_cutpoint(mdt_clin, time = "MFS.year", event = "MFS", variables = c("C5AR2","MME"))
summary(res.cut.mfs)
#use the optimized cutoff to stratify samples
    res.cat <- data.table(surv_categorize(res.cut.mfs))
    res.cat[, sample:=mdt_clin$gsm]
    head(res.cat)
    res.cat[(C5AR2!="high" | MME!="high"), mark_group:="high-"]
    res.cat[C5AR2=="high" & MME=="high", mark_group:="high+"]
    res.cat[,.N, by=mark_group]

  #merge into final survival data, create survivial object
  mdt_clin[, mark_group_mfs:= res.cat$mark_group]

  #calculate the difference
  return(mdt_clin)
}

surv_data_10y <- cutoff_surv(mdt_clin_10y)
surv_data_5y <- cutoff_surv(mdt_clin_5y)

## plot the survival plot and p value
sfit_10y = survfit(Surv(MFS.year, MFS) ~ mark_group_mfs, data=surv_data_10y)
sfit_5y = survfit(Surv(MFS.year, MFS) ~ mark_group_mfs, data=surv_data_5y)

ylab1 = "Metastais Free Survival\n 10 years"
ylab2 = "Metastais Free Survival\n 5 years"

p_mfs_10=ggsurvplot(sfit_10y, data = surv_data_10y,
                     pval =TRUE, pval.method = T,
                   risk.table=T,
                     xlab ="Time in years",
                     ylab =ylab1,
                     # surv.median.line="hv",
                     font.x = c(18, "plain", "black"),
                     font.y = c(18, "plain", "black"),
                     font.tickslab = c(18, "plain", "black"),
                     legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                     palette = c( "#00AFBB","#FC4E07"),
                     # facet.by = c("PAM50"),
                     ggtheme =theme_light())
print(p_mfs_10)

p_mfs_5=ggsurvplot(sfit_5y, data = surv_data_5y,
                  pval =TRUE, pval.method = T,
                  xlab ="Time in years",
                  ylab =ylab1,
                  conf.int=F,risk.table=T,
                  # surv.median.line="hv",
                  font.x = c(18, "plain", "black"),
                  font.y = c(18, "plain", "black"),
                  font.tickslab = c(18, "plain", "black"),
                  legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                  palette = c( "#00AFBB","#FC4E07"),
                      ggtheme =theme_light())
print(p_mfs_5)


p_survmfs <- cowplot::plot_grid(p_mfs_10$plot, p_mfs_10$table, 
                                p_mfs_5$plot,p_mfs_5$table,
                         nrow = 4, align = "v", rel_heights = c(3,1.25))
p_survmfs
png(filename = "e:/data/target/paper1/figs/CD10-surv-MFS-hatzis.png", width=420, height = 720)
p_survmfs
dev.off()


## plot different subtypes: HER2 negative and ER+/-
## plot different subtypes: HER2 negative and ER+/-
## plot different subtypes: HER2 negative and ER+/-

mdt_clin_5y <- surv_data[HER2=="N" & ER!="I",][MFS.year <=5 & MFS.year >= 0.5]#
mdt_clin_10y <- surv_data[HER2=="N" & ER!="I",][MFS.year <=10 & MFS.year >= 0.5] ## &

res.cut.mfs <- surv_cutpoint(mdt_clin_10y, time = "MFS.year", event = "MFS", variables = c("C5AR2","MME"))
summary(res.cut.mfs)
#use the optimized cutoff to stratify samples
res.cat <- data.table(surv_categorize(res.cut.mfs))
res.cat[, sample:=mdt_clin_10y$gsm]
head(res.cat)
res.cat[(C5AR2!="high" | MME!="high"), mark_group:="high-"]
res.cat[C5AR2=="high" & MME=="high", mark_group:="high+"]
res.cat[,.N, by=mark_group]

#merge into final survival data, create survivial object
mdt_clin_10y[, mark_group_mfs:= res.cat$mark_group]

subsurv_data <- mdt_clin_10y
fit_ER_pos <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = subsurv_data[ ER=="P"] )
fit_ER_neg <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = subsurv_data[ ER=="N"] )

p_er_pos <- ggsurvplot(fit_ER_pos, data = subsurv_data[ER=="P"],
                       pval =TRUE, pval.method = T,
                       xlab ="Time in years",
                       ylab =ylab1,
                       conf.int=F,risk.table=T,
                       font.x = c(18, "plain", "black"),
                       font.y = c(18, "plain", "black"),
                       font.tickslab = c(18, "plain", "black"),
                       legend.title="ER+HER2-",
                       legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                       palette = c( "#00AFBB","#FC4E07"),
             ggtheme =theme_light() )
p_er_pos
p_er_neg <- ggsurvplot(fit_ER_neg, data = subsurv_data[ER=="N"],
                       pval =TRUE, pval.method = T,
                       risk.table=T,
                       xlab ="Time in years",
                       ylab =ylab1,
                       conf.int=F,risk.table=T,
                       # surv.median.line="hv",
                       font.x = c(18, "plain", "black"),
                       font.y = c(18, "plain", "black"),
                       font.tickslab = c(18, "plain", "black"),
                       legend.title="ER+HER2-",
                       legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                       palette = c( "#00AFBB","#FC4E07"),
                       ggtheme =theme_light() )
p_er_neg


p_her2 <- cowplot::plot_grid(p_er_pos$plot, p_er_pos$table, 
                                p_er_neg$plot,p_er_neg$table,
                                nrow = 4, align = "v", rel_heights = c(3,1.25))
p_her2
png(filename = "e:/data/target/paper1/figs/CD10-surv-her2_MFS-hatzis.png", width=420, height = 720)
p_her2
dev.off()


## plot different subtypes: GRADE 1&2/3
## plot different subtypes: GRADE 1&2/3
## plot different subtypes: GRADE 1&2/3
surv_data[, .N, by=grade]

mdt_clin_10y <- surv_data[grade %in% c(1,2,3),][MFS.year <=10 & MFS.year >= 0.5] ## &

#cutoff value
res.cut.mfs <- surv_cutpoint(mdt_clin_10y, time = "MFS.year", event = "MFS", variables = c("C5AR2","MME"))
summary(res.cut.mfs)
#use the optimized cutoff to stratify samples
res.cat <- data.table(surv_categorize(res.cut.mfs))
res.cat[, sample:=mdt_clin_10y$gsm]
head(res.cat)
res.cat[(C5AR2!="high" | MME!="high"), mark_group:="high-"]
res.cat[C5AR2=="high" & MME=="high", mark_group:="high+"]

# res.cat[(C5AR2!="low" | MME!="low"), mark_group:="low-"]
# res.cat[C5AR2=="low" & MME=="low", mark_group:="low+"]

#merge into final survival data, create survivial object
mdt_clin_10y[, mark_group_mfs:= res.cat$mark_group]
mdt_clin_10y[,.N, by=.(grade,mark_group_mfs)]
subsurv_data <- mdt_clin_10y
fit_grd12 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = subsurv_data[grade %in% c(1,2)] )
survdiff(Surv(MFS.year, MFS) ~ grade, data = subsurv_data[grade %in% c(1,2,3)] )
fit_grd3 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = subsurv_data[grade == 3] )

p_grd12 <- ggsurvplot(fit_grd12, data = subsurv_data[grade %in% c(1,2)],
                      pval =TRUE, pval.method = T,
                       xlab ="Time in years",
                       ylab ="Metastasis free survival \n 10 years",
                       font.x = c(16, "plain", "black"),
                       font.y = c(16, "plain", "black"),
                       font.tickslab = c(16, "plain", "black"),
                       legend.title="grade 1&2",
                      legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                      palette = c( "#00AFBB","#FC4E07"),
                       conf.int=F, risk.table=T,
                      # facet.by = "grade",
                       ggtheme =theme_light() )
p_grd12
p_grd3 <- ggsurvplot(fit_grd3, data = subsurv_data[grade==3],
                     pval =TRUE, pval.method = T,
                       xlab ="Time in years",
                       ylab ="Metastasis free survival \n 10 years",
                     font.x = c(16, "plain", "black"),
                     font.y = c(16, "plain", "black"),
                     font.tickslab = c(16, "plain", "black"),
                       legend.title="grade 3",
                     legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                     palette = c( "#00AFBB","#FC4E07"),
                     conf.int=F, risk.table=T,
                       ggtheme =theme_light() )
p_grd3

p_grd <- cowplot::plot_grid(p_grd12$plot, p_grd12$table, 
                             p_grd3$plot,p_grd3$table,
                             nrow = 4, align = "v", rel_heights = c(3,1.25))
p_grd
png(filename = "e:/data/target/paper1/figs/CD10-surv-grade_MFS-hatzis.png", width=420, height = 720)
p_grd
dev.off()


## plot different subtypes: stage 1&2/3
## plot different subtypes: stage 1&2/3
## plot different subtypes: stage 1&2/3
surv_data[, .N, by=stage]
mdt_clin_10y <- surv_data[stage !="T0", ][MFS.year <=10 & MFS.year >= 0.5] ## &

res.cut.mfs <- surv_cutpoint(mdt_clin_10y, time = "MFS.year", event = "MFS", variables = c("C5AR2","MME"))
summary(res.cut.mfs)
#use the optimized cutoff to stratify samples
res.cat <- data.table(surv_categorize(res.cut.mfs))
res.cat[, sample:=mdt_clin_10y$gsm]
head(res.cat)
res.cat[(C5AR2!="high" | MME!="high"), mark_group:="high-"]
res.cat[C5AR2=="high" & MME=="high", mark_group:="high+"]
# res.cat[(C5AR2!="low" | MME!="low"), mark_group:="low-"]
# res.cat[C5AR2=="low" & MME=="low", mark_group:="low+"]

res.cat[,.N, by=mark_group]

#merge into final survival data, create survivial object
mdt_clin_10y[, mark_group_mfs:= res.cat$mark_group]

subsurv_data <- mdt_clin_10y
fit_stage12 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = subsurv_data[stage %in% c("T1","T2")] )
survdiff( Surv(MFS.year, MFS) ~ mark_group_mfs, data = subsurv_data[stage %in% c("T1","T2")] )
survdiff( Surv(MFS.year, MFS) ~ mark_group_mfs, data = subsurv_data[stage %in% c("T3","T4")] )
fit_stage34 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = subsurv_data[stage %in% c("T3", "T4")] )

p_st12 <- ggsurvplot(fit_stage12, data = subsurv_data[stage %in% c("T1","T2")],
                     pval =TRUE, pval.method = T,
                       xlab ="Time in years",
                       ylab ="Metastasis free survival \n 10 years",
                       font.x = c(16, "plain", "black"),
                       font.y = c(16, "plain", "black"),
                       font.tickslab = c(16, "plain", "black"),
                       legend.title="Stage I&II",
                     legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                     palette = c( "#00AFBB","#FC4E07"),
                       conf.int=F, risk.table=T,
                       ggtheme =theme_light() )
p_st12
p_st34 <- ggsurvplot(fit_stage34, data = subsurv_data[stage %in% c("T3","T4")],
                     pval =TRUE, pval.method = T,
                       xlab ="Time in years",
                       ylab ="Metastasis free survival \n 10 years",
                     font.x = c(16, "plain", "black"),
                     font.y = c(16, "plain", "black"),
                     font.tickslab = c(16, "plain", "black"),
                       legend.title="Stage III&IV",
                     legend.lab=c("Non-CD10hiGPR77hi","CD10hiGPR77hi"),
                     palette = c( "#00AFBB","#FC4E07"),
                       conf.int=F, risk.table=T,
                       ggtheme =theme_light() )
p_st34


p_stage <- cowplot::plot_grid(p_st12$plot, p_st12$table, 
                              p_st34$plot,p_st34$table,
                            nrow = 4, align = "v", rel_heights = c(3,1.25))
p_stage
png(filename = "e:/data/target/paper1/figs/CD10-surv-stage_MFS-hatzis.png", width=420, height = 720)
p_stage
dev.off()



###########################################Test for ATAT1################################

cutoff_surv <- function(mdt_clin=mdt_clin_10y, genename="ATAT1")
{
  # mdt_clin=mdt_clin_10y
  res.cut.MFS <- surv_cutpoint(mdt_clin, time = "MFS.year", event = "MFS", variables = genename)
  summary(res.cut.MFS)
  #use the optimized cutoff to stratify samples
  res.cat.MFS <- data.table(surv_categorize(res.cut.MFS))[, get(eval(genename))]
  #merge into final survival data, create survivial object
  mdt_clin[, mark_group_mfs:= res.cat.MFS]
  mdt_clin[,.N, by=.(mark_group_mfs)]
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

ylab1 = "Metastasis Free Survival\n 10 years"
ylab2 = "Metastasis Free Survival\n 5 years"
mdt_clin_5y <- surv_data[MFS.year <=5 & MFS.year >= 0]#
mdt_clin_10y <- surv_data[MFS.year <=10 & MFS.year >= 0]#
surv_data_10y <- cutoff_surv(mdt_clin_10y, genename="ATAT1")
surv_data_5y <- cutoff_surv(mdt_clin_5y, genename="ATAT1")
sfit_10y = survfit(Surv(MFS.year, MFS) ~ mark_group_mfs, data=surv_data_10y)
sfit_5y = survfit(Surv(MFS.year, MFS) ~ mark_group_mfs, data=surv_data_5y)
p_os10 <- surv_plot(sfit=sfit_10y,  data = surv_data_10y,  ylab =ylab1)
p_os5 <- surv_plot(sfit=sfit_5y,  data = surv_data_5y,  ylab =ylab2)

library(cowplot)
p_os <- plot_grid(p_os10$plot, p_os10$table, 
                  p_os5$plot,p_os5$table,
                  nrow = 4, align = "v", rel_heights = c(3,1.25))
p_os
png(filename = "figs/atat1-survMFS-Hatzis.png", width=420, height = 720)
p_os
dev.off()

########################### Subtypes for ATAT1######################################
## plot the survival plot and p value
surv_plot <- function(sfit=sfit_10y,  data = surv_data_10y,  ylab =ylab1, legtitle="Stage III&IV") {
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
                  legend.title=legtitle, #"Stage III&IV",
                  palette = c("#00AFBB", "#FC4E07"),
                  ggtheme =theme_light())
  p_os
}

mdt_clin_5y <- surv_data[MFS.year <=5 & MFS.year >= 0]
mdt_clin_10y <- surv_data[MFS.year <=10 & MFS.year >= 0]

subsurv_data <- surv_data_5y
subsurv_data <- surv_data_10y
surv_data_st12 <- cutoff_surv(subsurv_data[stage %in% c("T1","T2")], genename="ATAT1")
surv_data_st34 <- cutoff_surv(subsurv_data[stage %in% c("T3", "T4")] , genename="ATAT1")
fit_stage12 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = surv_data_st12 )
fit_stage34 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = surv_data_st34)

p_st12 <- surv_plot(sfit=fit_stage12,  data = surv_data_st12,  ylab =ylab1,legtitle="Stage I&II")
p_st34 <- surv_plot(sfit=fit_stage34,  data = surv_data_st34,  ylab =ylab1,legtitle="Stage III&IV")

library(cowplot)
p_os <- plot_grid(p_st12$plot, p_st12$table, 
                  p_st34$plot, p_st34$table,
                  nrow = 4, align = "v", rel_heights = c(3,1.25))
p_os
png(filename = "figs/atat1-survMFS_stage-Hatzis.png", width=420, height = 720)
p_os
dev.off()


subsurv_data <- surv_data_10y
surv_data_st12 <- cutoff_surv(subsurv_data[stage %in% c("T1","T2")], genename="ATAT1")
surv_data_st34 <- cutoff_surv(subsurv_data[stage %in% c("T3", "T4")] , genename="ATAT1")
fit_stage12 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = surv_data_st12 )
fit_stage34 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = surv_data_st34)

p_st12 <- surv_plot(sfit=fit_stage12,  data = surv_data_st12,  ylab =ylab1,legtitle="Stage I&II")
p_st34 <- surv_plot(sfit=fit_stage34,  data = surv_data_st34,  ylab =ylab1,legtitle="Stage III&IV")

library(cowplot)
p_os <- plot_grid(p_st12$plot, p_st12$table, 
                  p_st34$plot, p_st34$table,
                  nrow = 4, align = "v", rel_heights = c(3,1.25))
p_os
png(filename = "figs/atat1-surv_stageMFS-Hatzis.png", width=420, height = 720)
p_os
dev.off()



##GRADE classification

subsurv_data <- surv_data_5y
subsurv_data <- surv_data_10y
surv_data_grd12 <- cutoff_surv(subsurv_data[grade %in% c(1,2)], genename="ATAT1")
surv_data_grd3 <- cutoff_surv(subsurv_data[grade == 3] , genename="ATAT1")
fit_grd12 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = surv_data_grd12 )
fit_grd3 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = surv_data_grd3 )

p_grd12 <- surv_plot(sfit=fit_grd12,  data = surv_data_grd12,  ylab =ylab1,legtitle="Grade 1&2")
p_grd3 <- surv_plot(sfit=fit_grd3,  data = surv_data_grd3,  ylab =ylab1,legtitle="Grade 3")

library(cowplot)
p_os <- plot_grid(p_grd12$plot, p_grd12$table, 
                  p_grd3$plot, p_grd3$table,
                  nrow = 4, align = "v", rel_heights = c(3,1.25))
p_os
png(filename = "figs/atat1-surv_gradeMFS-Hatzis.png", width=420, height = 720)
p_os
dev.off()


subsurv_data <- surv_data_10y
surv_data_st12 <- cutoff_surv(subsurv_data[stage %in% c("T1","T2")], genename="ATAT1")
surv_data_st34 <- cutoff_surv(subsurv_data[stage %in% c("T3", "T4")] , genename="ATAT1")
fit_stage12 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = surv_data_st12 )
fit_stage34 <- survfit( Surv(MFS.year, MFS) ~ mark_group_mfs, data = surv_data_st34)

p_st12 <- surv_plot(sfit=fit_stage12,  data = surv_data_st12,  ylab =ylab1,legtitle="Stage I&II")
p_st34 <- surv_plot(sfit=fit_stage34,  data = surv_data_st34,  ylab =ylab1,legtitle="Stage III&IV")

library(cowplot)
p_os <- plot_grid(p_st12$plot, p_st12$table, 
                  p_st34$plot, p_st34$table,
                  nrow = 4, align = "v", rel_heights = c(3,1.25))
p_os
png(filename = "figs/atat1-surv_stageMFS-Hatzis.png", width=420, height = 720)
p_os
dev.off()

