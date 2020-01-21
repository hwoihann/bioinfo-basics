summary @github.com/hwoihann/bioinfo-toolkit/lists/exp.tools/geneEditing/screening.md

daily notes are add here


# 1. Basics of Genetic Screen: History, key of a genetic screen and related labs

## 1. Genetic Screening

Definition collection

http://www.stemcellsresearch.net/genetic-screen/
>  * A Genetic screen is the procedure or step to identify and select the individuals who possess the phenotype of interest. A genetic screen for new genes is often referred as the forward genetics and not the reverse genetics which the term to identify the mutant alleles that are already known. The mutant alleles that are not tagged for the rapid cloning are mapped and cloned by the positional cloning.

https://www.nature.com/scitable/definition/genetic-screen-200/
> * A genetic screen is screen is a laboratory procedure used to create and detect a mutant organism. It also goes by the name mutagenesis screen. In order to identify the function of an unknown gene, one strategy is to introduce general mutations into an organism and then study both the mutant and the control organisms in hopes of detecting a difference in their physical properties or phenotypes.
* Mutations can be introduced into an organism's genome by exposing the organism to a mutagen, which is an agent that changes the DNA. Commonly used mutagens include environmental agents, such as ultraviolet light, and chemical agents, such as ethylmethane sulfonate. The process of introducing mutations in DNA is called mutagenesis. Following mutagenesis, a systematic screening of the mutant and control organisms is performed to detect any difference in their phenotypes. The screening process may include visual observations of the organisms' appearances, behavioral tests, and physiological examinations. Once an abnormal phenotype is detected, the mutated gene can be identified by linkage mapping and the gene can be sequenced. Additional studies can then be performed to better understand the gene's functions.



## 1.1 mutagenesis screen

A genetic screen is screen is a laboratory procedure used to create and detect a mutant organism.

Mutation introduction: Mutations can be introduced into an organism's genome by exposing the organism to a mutagen, which is an agent that changes the DNA.
+ mutagen
 - environmental agents (ultraviolet light e.g.)
 - chemical agents (ethylmethane sulfonate e.g.)

+ mutagenesis: The process of introducing mutations in DNA is called mutagenesis.


Successful forward genetic screens
1. a defined genetic background of the organism being used
2. a simple yet constant experimental procedure to identify mutants of interest.

2.

Person:
Christiane Nüsslein-Volhard and Eric Wieschaus were the first individuals to perform this type of screening procedure.


### 1.2 enhancer screen
A genetic enhancer screen identifies mutations which enhance a phenotype of interest in an already mutant individual.
Usage:  Isolating enhancer mutants can lead to the identification of interacting genes or genes which act redundantly with respect to one another.

affected process of interest with a known gene mutation.

### 1.3 suppressor screen

Suppressor mutations can be described as second mutations at a site on the chromosome distinct from the mutation under study, which suppress the phenotype of the original mutation.

If the mutation is in the same gene as the original mutation it is known as intragenic suppression, whereas a mutation located in a different gene is known as extragenic suppression or intergenic suppression


Usage: Suppressor mutations are extremely useful to define the functions of biochemical pathways within a cell and the relationships between different biochemical pathways.


### 1.4  temperature sensitive screen




## 临床




##

Historically, pooled screens have relied on enriching populations of cells for a phenotype of interest, followed by next-generation sequencing (NGS) to measure changes in perturbation abundance. Common enrichment-based phenotypes include differential cell fitness (e.g., under drug selection) (Shalem et al., 2014, Wang et al., 2014) and differential fluorescence of a marker (e.g., a genetic reporter or immunostained protein), followed by separation of a target population via fluorescence-activated cell sorting (FACS) (Parnas et al., 2015).
pooled screen可以筛选出有特定表型的细胞系，用NGS方法去定量扰动程度。常见的表型富集方法包括药物筛选下的细胞活力，有特定marker的细胞系（比如报告基因，免疫荧光染色蛋白）






# 2. Basic of CRISPR screen: Lab, key experiment skills, and...
cellular phenotypes selection strategy:
1. based on cell lethality or growth. (Shalem et al., 2014, Wang et al., 2014)
2. molecular markers (Parnas et al., 2015)





## 2.1 Screen原理

### 2.1.1 CRISPR基本原理
在化脓性链球菌(S. pyogenes)中，Cas9通过蛋白质中两个催化结构域介导的过程产生了一个钝端的、双链断裂的3 bp 上游序列:
一个是切断 DNA 互补链的 HNH 结构域，另一个是切断非互补序列类 ruvc 结构域。

![CRISPRi-fig](/images/2020/01/2020-01-16_15-43.png)

### 2.1.2  CRISPRa

为了实现 rna 引导的基因组调控，必须首先通过消融 RuvC 和 HNH 核酸酶域7的天然活性来消除 Cas9核酸酶活性。 通过寻找与 Cas9(补充注释1)同源的已知结构序列，我们鉴定并突变了最多四种推测参与镁配位的氨基酸(补充图1a)。 由此产生的四重 Cas9突变体在目标位点的深度测序中显示出无法检测的核酸酶活性(补充图1b) ，这意味着我们已经成功地将 Cas9核酸酶活性降低到检测阈值以下的水平。

为了获得转录激活的 Cas9N 融合蛋白，我们将 VP64激活域15直接融合到 Cas9N-的 c 端(图1a)。 该 Cas9N-VP64蛋白与 sgRNA 靶向启动子附近的序列结合时，可稳定激活报告基因的转录，从而显示 rna 引导的转录激活(图1c、 d 和补充图1c)。

本质：dCAS9+ MS2-VP64 fusion protein


early CRISPRa: only one activator domain,
current derivatives:
1. synergistic activation mediator (SAM)
2. fusion of multiple activator domains to achieve more robust gene activation
   - VP64
   - MS2 bacteriophage coat proteins
   - NF-kB trans-activating subunit p65
   - or an activation domain from human heat-shock factor 1

将转录激活域直接绑定到核酸酶缺失的 Cas9蛋白，或者绑定到核酸适配体修饰的单一指导 RNA (sgRNA) ，使 RNA 引导的基因组调控在人类细胞中得以实现。


ref1: George M Church 2015 NM  https://www.ncbi.nlm.nih.gov/pubmed/23849981?dopt=Abstract
ref2: Jonathan S.Weissman Lei S.Qi CRISPR-Mediated Modular RNA-Guided Regulation of Transcription in Eukaryotes https://www.nature.com/articles/nbt.2675


证明CRISPRa激活效应的实验：
1. FACS
2. qPCR
