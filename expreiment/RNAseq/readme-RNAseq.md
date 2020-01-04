# protocol for library construction of RNAseq

1. RNA extraction, quantification, QC

Usage: gene expression analysis
 - detection of mutations
 - fusion transcripts
 - alternative splicing
 - post-transcriptional modifications.

主要步骤：
1. 非mRNA的RNA去除，mRNA富集
   -  ribosomal RNA (rRNA)
   -  globin RNA is generally removed from blood samples
   - chloroplast RNA is often removed from plant leaf samples
2. 片段化：逆转录前需要将mRNA都打断
3. 逆转录和二链cDNA合成
4. 末端修复，dA加尾，加接头

Protocol for Enrichment of mRNAs, excluding Globin mRNA, from Whole Blood Total RNA

如何精确测量input RNA的质与量？
1. RNA完整性(RNA Integrity): 可以用bioanalyzer 或者fragment analyzer分析获得RIN值
2. 2:1 ratio (28S:18S) is a good indication that the RNA is completely intact.
3. DNase digestion of the purified RNA with RNase-free DNase is recommended.


## RNA extraction using Trizol



## Basic calculations in RNAseq
https://newonlinecourses.science.psu.edu/stat555/node/78/
https://hbctraining.github.io/Intro-to-rnaseq-hpc-O2/lessons/05_counting_reads.html



### 1. normalization: RPM/RPKM/TPM
Scale the read count per gene/transcript towards the total read count of the sequencing run in order to compensate for different sequencing depths.




Transcript Count Per Million
TPM (Transcripts Per Million) refers to how much RNA is present in a sample.
https://statquest.org/2015/07/09/rpkm-fpkm-and-tpm-clearly-explained/


RNA library
The RNA that was sequenced is called the RNA library. Library size could mean one of two things: the total number of reads that were sequenced in the run or the total number of mapped reads.
