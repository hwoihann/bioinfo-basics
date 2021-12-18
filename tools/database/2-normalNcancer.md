2020/05/23 Sat. 13:59:36

# Aim
Compare the expression of a gene between normal and cancer tissues.

## 1. GENT2
Park, S.-J., Yoon, B.-H., Kim, S.-K., & Kim, S.-Y. (2019). GENT2: An updated gene expression database for normal and tumor tissues. BMC Medical Genomics, 12(5), 101. https://doi.org/10.1186/s12920-019-0514-7

an updated gene expression database for normal and tumor tissues

https://bmcmedgenomics.biomedcentral.com/articles/10.1186/s12920-019-0514-7


We collected data from the NCBI GEO public database and processed them with the MAS5 algorithm using the affy package in Bioconductor

36 cancer types
68,140 samples with cancer subtype profiling


The GENT2 system consists of the following two main parts: indexed DB and web-based user interface.
 - a database that can handle a __huge gene expression profile (over 68,000 cancer patients)__: Apache Lucene index machine (ver. 7.4.0) into whole gene expression datasets.
 - A web-based graphical user interface (GUI) was implemented with the Google Web Toolkit (GWT, ver. 2.7.0) and GWT extended (GXT, ver. 4.0.0) frameworks based on JAVA language.
Statistical tests:
two-sample t-test, Kaplan-Meier with log-rank test, and meta-survival analysis with Cox proportional hazard modes, were implemented using R (ver. 3.2.5) with Bioconductor plugins (ver. 3.6).

![gent2Des1](/images/2020/05/2020-05-23_14-20.png)


Assay platform: Affymetrix U133Plus2 and the Affymetrix U133A platform, allowing users to compare both results.
1. Tissue- and cell line-wide expression profile comparing normal and tumor samples
2. Subtype profiling with survival analysis
3. Meta-survival analysis



Many databases have been developed that show gene expression of cancer samples. For instance, Oncopression [12], CellLineNavigator [13], MERAV [14], Oncomine [15], cBioPortal [16], RNA Seq Atlas [17], KM-Express [18], BioXpress [19], TiGER [20], and so on (Table 4). Each database has its own unique advantages. First, Oncopression, CellLineNavigator, and MERAV are databases that can investigate gene profiling around the collected microarray datasets for various cancer types. Oncomine, cbioPortal, and RNA Seq Atlas are databases that analyze gene profiling for each dataset based on a microarray and RNA-sequencing. These databases have the benefit of comparing information between two high-throughput platforms. In addition, Oncomine and cBioPortal provide versatile and additional functions such as multidimensional comparison of samples (Oncomine) or integrated analysis of CNV, mutation, coexpression, and gene enrichment (cBioPortal). Lastly, the TiGER database contains EST data around several tissues. In many respects, they are very similar to GENT2 database.
**However, GENT2 has many useful features such as subtype analysis and meta-survival analysis, which are not available in other databases. In addition, an intuitive and user friendly interface is another advantage of GENT2 (Fig. 5).**


MAS5算法是由Affymetrix公司设计开发的，其对于芯片背景噪音的校正采用了比较直接的策略，即通过计算PM[i]-MM[ii]或PM/MM实现信噪分离。理论上讲，MM探针只有非特异杂交信号，不会有特异性杂交，因此MM探针的信号值应始终小于其对应的PM探针信号值。但是，在实际分析过程中，经常发现甚至多达三分之一的MM探针信号值高于对应PM探针信号值。RMA算法并不直接利用MM的信号去除背景噪音，而是基于20组探针的信号分布采用随机模型来评估表达值，对于低噪号的实验有更好的适用性。

Affymetrix芯片标准化处理一般可以概述为四个步骤，包括：背景修正(Background correction)，系统校正(Normalization)，PM修正，表达值综合(Summary)。

https://www.jianshu.com/p/19020c0383a1



## 2. GTEX

https://www.broadinstitute.org/blog/gtex-useful-expression-cancer-research


## 3. UCSCxena

## 4. cBioportal
