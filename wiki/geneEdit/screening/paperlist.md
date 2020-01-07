# Analysis needs to be repeated

## [paper#1: A Genome-wide CRISPR Screen in Primary Immune Cells to Dissect Regulatory Networks. Cell, 162(3), 675–686. Parnas, O., Jovanovic, M., Eisenhaure, T. M., Herbst, R. H., Dixit, A., Ye, C. J., … Regev, A. (2015).](https://www.sciencedirect.com/science/article/pii/S0092867415008296?via%3Dihub)
引入了全基因组的 CRISPR-Cas9文库到树突状细胞(dc)中，以确定控制细菌脂多糖(LPS)诱导肿瘤坏死因子(Tnf)的基因，这是宿主对病原体反应的一个关键过程，通过Tlr4途径介导。
### paper#1. Summs
Introduce genome-wide pooled CRISPR-Cas9 libraries into dendritic cells (DCs) to identify genes that control the induction of tumor necrosis factor (Tnf) by bacterial lipopolysaccharide (LPS), a key process in the host response to pathogens, mediated by the Tlr4 pathway.

found: many of the known regulators of Tlr4 signaling, as well as dozens of previously unknown candidates that we validated.

By measuring **protein markers and mRNA profiles** in DCs that are deficient in known or candidate genes, we classified the genes into three functional modules with distinct effects on
 - the canonical responses to LPS and
 - highlighted functions for the PAF complex and
 - oligosaccharyltransferase (OST) complex.

Our findings uncover new facets of innate immune circuits in primary cells and provide a genetic approach for dissection of mammalian cell circuits.
原代细胞先天免疫回路的新面貌，并为解剖哺乳动物细胞回路提供了一种遗传学途径
### paper#1. Details

currently **two major strategies for associating targets with their putative regulators** on a genomic scale (reviewed in Kim et al., 2009):
  1. observational (correlative) approaches that relate them based on statistical dependencies in their quantities or physical associations and
  2. perturbational (causal) approaches that relate them by the effect that a perturbation in a putative regulator has on its target.

>genomic profile classification (e.g.,
   - of mRNAs,
   - protein-DNA binding,
   - protein levels,
   - protein phosphorylation


In such screens, pooled libraries are introduced into cell lines and cellular phenotypes are selected based on cell lethality or growth.
 - Cell origin: bone-marrow-derived dendritic cells (BMDCs, or DCs) isolated from Cas9-expressing transgenic mice.
 - Library: a pooled CRISPR strategy to dissect the innate immune response
 - Steps:
  1. infected DCs with a pooled, genome-wide library of lentiviruses
  2. stimulate them with lipopolysaccharide (LPS),
  3. monitore their responses by intra-cellular staining for the inflammatory cytokine Tnf, a major marker of the early response to LPS.
脂多糖(LPS)
 - Analysis:
  1. Use flow cytometry to isolate cells that failed to fully induce Tnf or that induced it more strongly,
  2. determine sgRNA abundance by deep sequencing.

 - Result:
  1. recovered many of the key known regulators of TLR signaling, validated dozens of new regulators,
  2. identified three functional modules of regulators with distinct regulatory effects.

 - Significance:
  1. identifies new facets in the complex response of immune cells to pathogens
  2. provides **a general strategy** for systematically dissecting circuits in other primary mammalian cells.

### paper#1. Subtitle and summs
1. A System for Cell-Autonomous, Pooled Genetic Screens in BMDCs Derived from Cas9-Expressing Mice
细胞自主分类系统
Tlr4，感知细菌内毒素的细胞细胞表面受体;  正相关
Myd88，Tlr4信号转导诱导 Tnf 的关键成分; 正相关
Zfp36，一种破坏 Tnf mRNA 稳定性的 rna 结合蛋白。负相关
Brefeldin a 阻断 Tnf 的分泌

2. A Genome-wide Pooled sgRNA Library Screen in Primary BMDCs
3. The Screen Correctly Identifies Known Regulators of Cell Viability, Differentiation, Tnf Expression, and Tlr4 Signaling
筛选正确识别已知的细胞活性、分化、 Tnf 表达和 Tlr4信号调节因子
4. Dozens of Positive Regulators Identified by the Screen Validated Using Individually Cloned sgRNAs
利用单独克隆的 sgRNAs 筛选确认的几十个正向调节器

5. Optimized Characterization of Novel Negative Regulators by Analysis at Unsaturated Levels of Tnf
6. A Deeper Secondary Pooled Screen Uncovers Additional Regulators with Greater Sensitivity and Specificity
7. Positive Tnf Regulators Are Organized in Functional Modules by Their Impact on RNA and Protein Expression
8. Components of the OST Complex and the ER Folding and Translocation Pathway Are Important for Tnf Expression in Response to LPS
9. The PAF Complex and Its Physical Interactors Form a Module that Positively Regulates Tnf Protein Expression

### paper#1. Figure legend:
Figure 1. A Genome-wide Pooled CRISPR Screen in Mouse Primary DCs
Figure 2. Individual sgRNAs Verify Dozens of Top Hits from the Pooled Screen
Figure 3. The validated positive regulators partition into key modules by their effect on protein and RNA expression
Figure 4. The OST complex strongly affects the BMDC inflammatory response
Figure 5. The Paf complex strongly affects the LPS response


fig1
a.control system;b.experiment process;
c. **Cumulative distribution function (CDF) plots** of the gene level Z-score distribution of genes annotated as ‘‘essential’’ (purple) and ‘‘core essential’’ (black) in Hart et al. (2014), ‘‘translation’’ (in GO, blue), and all other genes (gray).
d. (Left) Binned Z scores (ZS) of the Tnflo/Tnfhi ratios (y axis) versus sgRNA mean abundances in Tnflo and Tnfhi (x axis). (Right) Gene score distribution for positive (ZS) and negative (ZS) regulators (Experimental Procedures).
e. CDFs of screen ranks for the 35 genes in the TLR pathway from LPS to Tnf (KEGG, blue), non-targeting controls (black), and all other genes (gray).


### paper#1. Experimental Procedures
1. Pooled Genome-wide CRISPR Screen
2. Cloning of Individual and Libraries of sgRNAs and Subsequent Viral Production

## discussion
### tl#1: 为什么可以发到这个文章上，新意在哪里？

### tl#2: 找到关键基因后怎么缩小范围？

### tl#3: 涉及的生信分析方法？





## [paper#2](https://www.nature.com/articles/nature13166)
