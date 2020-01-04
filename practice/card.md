layout: true
class:
<!-- center, middle, inverse -->
<!-- background-image: url(image.jpg) -->

---

# Cards for bioinformatic resources
## 1. Tumor
## 2. Immnune


.footnote[11/18/2019, Huihan]

---
name: light
layout: false
class: top

### 1. [CCLE](https://portals.broadinstitute.org/ccle/about)
Cancer Cell Line Encyclopedia
 - Definition: provides public access to genomic data, analysis and visualization for over 1100 cell lines.
 - Goal: Conduct a detailed genetic and pharmacologic characterization of a large panel of human cancer models, to develop integrated computational analyses that link distinct pharmacologic vulnerabilities to genomic patterns and to translate cell line integrative genomics into cancer patient stratification.
 - Sample type <img alt="card-687dab76.png" src="practice/assets/card-687dab76.png" width="220" height="" >
 - Dataset type:
    1. Copy Number
    2. mRNA expression (Affy)
    3. RPPA
    4. RRBS
    5. mRNA expression (RNAseq)
 - Funding: norvatis
 - Local address

---

### 2. [Depmap:  Cancer Dependency Map project](https://depmap.org/portal/interactive/)

DepMap CRISPR–Cas9 knockout dataset: 483 CCLE cell lines have been screened with a library of ~74,000 sgRNAs targeting ~17,000 genes: 
Unbiased metabolite-dependency association analysis shows that the dissimilar metabolic phenotypes observed in cancer cell lines are paired with distinct gene dependencies and, therefore, potential therapeutic targets



---

## 3. [GTEx](https://www.gtexportal.org/)
 - Goal: help researchers to understand inherited susceptibility to disease, provide to the scientific community a resource with which to study human gene expression and regulation and its relationship to genetic variation. （建立表达调控和遗传变异的相关性）
 - Definition: By analyzing global RNA expression within individual tissues and treating the expression levels of genes as quantitative traits, variations in gene expression that are highly correlated with genetic variation can be identified as expression quantitative trait loci, or eQTLs.
 - Sample
   1. Tissue: 54
   2. Donor: about 900
 - Dataset
 - Funding
 - Local address

eQTL: expression quantitative trait loci, or eQTLs
<img alt="card-f0602abd.png" src="./practice/assets/card-f0602abd.png" width="300" height="" >


---

name: table template
# Mapping efficiency & total reads

.pure-table.pure-table-bordered.pure-table-striped.smaller-font[
|sampleID            | readMiliion| multiMap%|   uniMap%|    noMap%|
|:-------------------|-----------:|---------:|---------:|---------:|
|2xFlag_TetTKO_input |   37.546244| 0.5341571| 0.4290482| 0.0367948|
|2xFlag_WT_input     |   33.497314| 0.3641530| 0.6016375| 0.0342095|

]


???
Technical problem?

---
name: figure template

### Compare the proportion of multiple hits on repeats in  DNAseq of tetTKO and tetWT

<img src="http://owxb9z5ea.bkt.clouddn.com/0319-scrShot_002.png" height="420">
Figure2: 2018 March. TetTKO by ZHY (TetKI: 2xFlag)

---

name: Conclussion
class: center, middle

For this moment, we couldn't explain the difference.

---
