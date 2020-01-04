# How to carry out a CRISPR Experiment



>  Task description
>
> - 在哪些实验上可以应用此技术，以及详细protocol
> - 哪些公共的database可以帮忙设计target片段，如何避免脱靶
> - 哪里可以买到所需耗材，实验室需要什么质粒系统，addgene上有没有可以买的质粒

主要参考：http://www.addgene.org/crispr/guide/#plan-experiment

## [FAQ before experiment](http://www.addgene.org/crispr/zhang/faq/)

> Q1: Where are double strand breaks (DSBs) induced, compared to where the target site sequence (protospacer+PAM) is located? If there are other PAMs in the region, will they also be targeted?

A: The Cas9 **cuts 3-4bp upstream of the PAM sequence**. There can be some off-target DSBs using wildtype Cas9. The degree of off-target effects depends on a number of factors, including: 

1. how closely homologous the off-target sites are compared to the on-target site
2. the specific site sequence, and the concentration of Cas9 and guide RNA (gRNA). 

These considerations only matter if the PAM sequence is immediately adjacent to the nearly-homologous target sites. The mere presence of additional PAM sequences should not be sufficient to generate off-target DSBs; there needs to be extensive homology of the protospacer followed by PAM.



> Q2: Can you summarize HR template vector design guidelines?

A: considerations for designing HR donor

1.  if off-target (non-specific) cleavage is not a very big concern, you could go ahead withPX330plasmid. Or double nickase system, withPX335vector, you need to find two guides for each cleavage site, but this system probably have better specificity. 
2. Target selection
   1. pick 3-6 guides around the region to find the most efficient guide (most guides would work, but they sometimes have different efficiency). 
   2. Cut site close to the junction of the homology arm as possible, less than 100bp away, ideally less than 10bp away.
3. For small (<50bp) changes, consider using ssDNA oligo as donor template, it's usually more efficient than plasmid donor. 
   1. Typical design is to have 50-80bp of homology arms on each side flanking the change you'd like to introduce. 
   2. Use Ultramer oligo from IDT (non-PAGE purified oligo is fine based on new data). 
   3. For general transfection, you could use 1ul of 10uM oligo stock for each well on 24-well plate, co-deliver into the cells with the Cas9/sgRNAs vector (like PX330).
4. large changes (>100bp insertions or deletions), typically use plasmid donor, 
   1. with two homology arms on each side flanking your desired insertion or mutation. Each arms is around 800bp.
   2. For transfection in cells like HEK, we use around 400ng of a typical size (~ 5kb) donor plasmid with Cas9/sgRNAs vector, for one well in 24-well plate. A good example/reference [Cell paper](http://www.cell.com/abstract/S0092-8674(13)01016-7)







## Part I: Basics. Plan your CRISPR Experiment

![1547804707644](/home/whh/.config/Typora/typora-user-images/1547804707644.png)

Select Desired Genetic Manipulation: 

- Knockout (Permanently disrupt gene function): Cas9 (or Cas9 nickase) + Single (or dual) gRNA targeting 5′ exon or essential protein domains
- Edit (Generate a specific user-defined sequence change ):  Cas9 (or Cas9 nickase)+ Base editor + Single (or dual) gRNA targeting the region where the edit should be made
- Repress or Interfere (CRISPRi): dCas9-repressor (such as dCas9-KRAB) or dCas9 + gRNA(s) targeting promoter elements of target gene
- Activate (CRISPRa, Increase expression of an endogenous gene(s) without permanently modifying the genome): dCas9-activator (such as dCas9-VP64) + gRNA(s) targeting promoter elements of target gene

### 1.1 Choose CRISPR Experiment type

- The Hammer: Gene Knockout by NHEJ
- The Jigsaw: Editing by HDR
- The Wrench: Gene Activation and Inhibition by CRISPRa and CRISPRi

![1547714819764](/home/whh/.config/Typora/typora-user-images/1547714819764.png)

### 1.2 Select Expression System

-  For easy-to-transfect cell types (e.g. HEK293 cells), transfection with standard transfection reagents may be sufficient to express the CRISPR machinery. 

- For more difficult cells (e.g. primary cells), viral delivery of CRISPR reagents may be more appropriate.

Considerations: 

- Species of Cas enzyme and gRNA
- Species of promoter and expression pattern of promoter for Cas enzyme and gRNA
- Presence of a selectable marker (drug or fluorophore)
- Delivery method

![1547714984307](/home/whh/.config/Typora/typora-user-images/1547714984307.png)



https://www.addgene.org/crispr/genomic-deletions-mammalian-cell-lines/



### 1.3 Select Your Target Sequence and Design Your gRNA

![grna design process diagram](https://media.addgene.org/data/easy-thumbnails/filer_public/cms/filer_public/6e/fd/6efd3e2e-f06b-4ee7-9552-081c3dcc8061/grna-design.png__386x500_q85_subsampling-2_upscale.png)

### 1.4 Procedures

1. Know your cell line/organism and genomic sequence

2. Select gene and genetic element to be manipulated

3. Select gRNAs based on predicted on-target and off-target activity

4. Synthesize and clone desired gRNAs

5. Deliver Cas9 and gRNA: [CRISPR delivery in mammalian systems](http://blog.addgene.org/crispr-101-mammalian-expression-systems-and-delivery-methods?_ga=2.76637845.1643129610.1547600919-867493703.1547600919)

   ![1547716307849](/home/whh/.config/Typora/typora-user-images/1547716307849.png)

6. Validate genetic modification

   - **Mismatch-cleavage assay (for NHEJ repaired DSBs)**: Provides a semi-quantitative readout of the percentage of alleles that have been mutated within a mixed cell population. The region of interest is PCR amplified, PCR products are denatured-renatured, treated with a nuclease that cleaves DNA heteroduplexes, and run on an agarose gel to identify DNA fragments.
   - **PCR and restriction digest** (for HDR repaired DSBs): For small nucleotide edits that introduce a novel restriction site. The region of interest is PCR amplified, digested with the appropriate restriction enzyme and run on an agarose gel to identify DNA fragments.
   - **PCR amplification and gel electrophoresis** (for HDR or NHEJ): For large deletions or insertions, the region of interest can be PCR amplified using primers that (A) flank the region of interest (deletions or small insertions) or (B) span the genome-insert boundary (insertions only). The PCR product is then run on an agarose gel to determine whether the edit was successful.
   - **PCR amplification, subcloning and Sanger sequencing** (for HDR or NHEJ): Provides semi-quantitative assessment of targeting frequency and exact sequence of targeted alleles. Involves PCR amplification of targeted region from DNA, subcloning into a plasmid, and screening individual clones.
   - **PCR amplification and next-generation sequencing** (for HDR or NHEJ): Provides quantitative assessment of the genome edits in your target sequence and can also be used to examine off-target effects.



### 













## Part II: Practice. Use CRISPR/cas9 to construct ATAT1-KO cell line





### Step1. Design sgRNA based on exon9, using crispor

![1547802302448](/home/whh/.config/Typora/typora-user-images/1547802302448.png)

![1547723829051](/home/whh/.config/Typora/typora-user-images/1547723829051.png)

> CRISPOR is a website that helps **select and express CRISPR guide sequences**. In its default mode, the user pastes an input DNA sequence and chooses the genome. CRISPOR then lists the guides in the input sequence, adding information about them found in databases and algorithms, including genome variants, predicted off-target and on-target scores. For each guide sequence, various **primers are designed**, e.g. to **amplify** the target, produce guide RNAs by **in vitro transcription** after annealing of overlapping primers or for **cloning into AddGene plasmids**.



Find information of [ATAT1]( https://genome.ucsc.edu/cgi-bin/hgGene?hgg_gene=ENST00000318999.11&hgg_prot=ENST00000318999.11&hgg_chrom=chr6&hgg_start=30626841&hgg_end=30644679&hgg_type=knownGene&db=hg38&hgsid=707265503_FmgGxv3kFtsnwqAoq4VbdIlqnawa)

> Human Gene ATAT1 (ENST00000318999.11, NM_001318762)
>
> chr6	30642767	30643015	NM_001318762.1_cds_8_0_chr6_30642768_f	0	+

exon1/9

>hg38_knownGene_ENST00000318999.11_0 range=chr6:30626886-30626992 5'pad=0 3'pad=0 strand=+ repeatMasking=none
>ATGGAGTTCCCGTTCGATGTGGACGCGCTGTTCCCGGAGCGGATCACGGT
>GCTGGACCAGCACCTGAGGCCCCCAGCCCGCCGACCCGGAACCACAACGC
>CGGCCCG



![1547797288603](/home/whh/.config/Typora/typora-user-images/1547797288603.png)

![1547724297335](/home/whh/.config/Typora/typora-user-images/1547724297335.png)

![1547719010020](/home/whh/.config/Typora/typora-user-images/1547719010020.png)

- specificity score: 0-100, uniqueness of a guide in the genome. [Hsu et al. Nat Biotech 2013](http://dx.doi.org/10.1038/nbt.2647). recommend values >50.
- Out-of- Frame: 0-100. Predicts the percentage of clones that will carry out-of-frame deletions, based on the micro-homology in the sequence flanking the target site. See Bae et al.. Click the score to show the most likely deletions for this guide.
- Off-targets for 0-1-2-3-4 mismatches: For each number of mismatches, the number of off-targets is indicated. *Example: 1-3-20-50-60 means 1 off-target with 0 mismatches, 3 off-targets with 1 mismatch, 20 off-targets with 2 mismatches, etc.*

![1547719118714](/home/whh/.config/Typora/typora-user-images/1547719118714.png)



### Step2: Cloning or expression of guide RNA

[cloning protocol](https://www.addgene.org/static/data/plasmids/52/52961/52961-attachment_B3xTwla0bkYD.pdf) for [pX330-U6-Chimeric_BB-CBh-hSpCas9 (Zhang lab)](https://www.addgene.org/42230/) + derivatives

![1547727630923](/home/whh/.config/Typora/typora-user-images/1547727630923.png)





















---

REFS

## 2. gRNA design for CRISPR Genome Editing

https://blog.addgene.org/how-to-design-your-grna-for-crispr-genome-editing?_ga=2.156305083.1643129610.1547600919-867493703.1547600919

- Predicting gRNA On-Target Activity

- Decreasing Off-Target Effects

### 2.1 

> the “best” gRNA depends an awful lot on what you are trying to do: gene knockout, a specific base edit, or modulation of gene expression.

![gRNADesignOverview_JD_2017_5_3v3-01.png](https://blog.addgene.org/hs-fs/hubfs/4_17_to_6_17/howToDesignGRNAUpdate_JD_2017_5_3/gRNADesignOverview_JD_2017_5_3v3-01.png?width=350&name=gRNADesignOverview_JD_2017_5_3v3-01.png)



Generate complete and permanent loss of gene expression or function (knockout)



### 2.2 sgRNA design



### 1.1 REAGENTS



- sgRNA preparation
  - Plasmids: pSpCas9
  - pUC19 (Invitrogen, cat. no. 15364-011) or any preferred cloning plasmid
  - PCR primers or oligos for sgRNA construction
  - UltraPure DNase/RNase-free distilled water (Life Technologies, cat. no. 10977-023)
  - Herculase II fusion polymerase with 5× reaction buffer 
- Genotyping analysis
  - PCR primers for SURVEYOR, RFLP analysis or sequencing; 
  - QuickExtract DNA extraction solution (Epicentre, cat. no. QE09050)
  - 



Species of Cas enzyme and gRNA
Species of promoter and expression pattern of promoter for Cas enzyme and gRNA
Presence of a selectable marker (drug or fluorophore)
Delivery method













