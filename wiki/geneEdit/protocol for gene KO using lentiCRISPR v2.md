# protocol for ATAT1-KO using lentiCRISPR v2

## Reagents

- sgRNA Plasmid construction

  - Plasmid: [lentiCRISPR v2](https://www.addgene.org/52961/), (Plasmid #52961)
  - FastDigest BbsI ([Fermentas](https://www.lifetechnologies.com/order/catalog/product/FD1014), )
  - FastAP ([Fermentas](http://www.thermoscientificbio.com/dna-and-rna-modifying-enzymes/fastap-thermosensitive-alkaline-phosphatase/), Catalog #: EF0654)
  - 10X FastDigest Buffer ([Fermentas](http://www.thermoscientificbio.com/dna-and-rna-modifying-enzymes/10x-fastdigest-green-buffer/))
  - QIAquick Gel Extraction Kit ([Qiagen](http://www.qiagen.com/products/catalog/sample-technologies/dna-sample-technologies/dna-cleanup/qiaquick-gel-extraction-kit))
  - 10X T4 Ligation Buffer ([NEB](https://www.neb.com/products/b0202-t4-dna-ligase-reaction-buffer))
  - T4 PNK ([NEB](https://www.neb.com/products/m0201-t4-polynucleotide-kinase))
  - sgRNAs in oligo pairs
  - 2X Quick Ligase Buffer ([NEB](https://www.neb.com/products/M2200-Quick-Ligation-Kit))
  - Quick Ligase ([NEB](https://www.neb.com/products/M2200-Quick-Ligation-Kit))

- Transformation needed: 

  - LB agar plate (with appropriate antibiotic)
  - LB or SOC Outgrowth Medium(NEB Catalog #: B9020S)
  - Competent cells: DH5-a

- PCR validation

  - [Taq DNA Polymerase (M0273)](https://www.protocols.io/view/PCR-with-Taq-DNA-Polymerase-M0273-imst9m)

  ## Procedure

  1. Design of targeting components and the use of the CRISPR Design Tool (1d)
     - Input target genomic DNA sequence.
     - Order oligos and primers for  [lentiCRISPR v2](https://www.addgene.org/52961/)：![1548167891330](/home/whh/.config/Typora/typora-user-images/1548167891330.png)
  2. Preparation of sgRNA expression construct (2d)
     - Digest and dephosphorylate 5ug of the lentiviral CRISPR plasmid with BsmBI for 30 min at 37C:
     - Gel purify digested plasmid using QIAquick Gel Extraction Kit and elute in EB.
     - Phosphorylate and anneal each pair of oligos(37 °C for 30 min; 95 °C for 5 min; ramp down to 25 °C at 5 °C min−1.)
     - Dilute annealed oligos from Step 3 at a 1:200 dilution into sterile water or EB. 
     - Set up ligation reaction and incubate at room temperature for 10 min:
     - Transformation into Stbl3 bacteria. [prepare competent cell, not ]
  3. Lentiviral production
     - Co-transfect into HEK293(F)T cells: 
       1. transfer plasmid (lentiCRISPRv2) 
       2. packaging plasmids pVSVg (AddGene 8454) and psPAX2 (AddGene 12260). 
       3. Positive control for viral production: CMV-EGFP lentiviral transfer plasmid (AddGene 19319)