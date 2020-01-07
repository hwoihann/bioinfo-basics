
## Procedure

 1. Digest and dephosphorylate 10 ug of the lentiviral CRISPR plasmid with BsmBI for 30 min at 37C:  
    lentiCRISPRv2 .......  10 ug   
    FastDigest Esp3l (Thermo#FD1014)  ...............   6 ul   
    FastAP ( Thermo#EF0651) ..........   6 ul   
    10X FastDigest Buffer (Themo#B64) ..........   12 ul   
    100 mM DTT (freshly prepared) ..........   1.2 ul   
    ddH2O .......... X ul  
    total ..........   120 ul   

 2. Gel purify digested plasmid using QIAquick Gel Extraction Kit and elute in ddH20  
    If Esp3l digested, a ~2kb filler piece should be present on the gel. Only gel purify the larger band. Leave the 2kb band.  

 3. Phosphorylate and anneal each pair of oligos:  
            Oligo 1 (100 µM) .........  1 ul  
            Oligo 2 (100 µM) .........  1 ul  
            10X T4 Ligation Buffer (NEB#B0202S) .........  1 ul  
            ddH2O .........  6.5 ul  
            T4 PNK (NEB#M0201S) .........  0.5 ul  
            total .........  10 ul    
    Put the phosphorylation/annealing reaction in a thermocycler using the following parameters
     - 37°C 30 min
     - 95°C 5 min and then ramp down to 25°C at 5°C/min

4. Dilute annealed oligos from Step 3 at a 1:200 dilution into sterile water or EB, by adding 1 μl of oligo to 199 μl of room temperature ddH2O.  1:100 work too

5. Set up ligation reaction and incubate at room temperature for 10 min perform a negative control ligation (vector-only with water in place of oligos) and transformation.   
        BsmBI digested plasmid from Step 2 (100ng)   ..........  X μL  
        diluted oligo duplex from Step 4  ..............    to 22μL  
        2X Quick Ligase Buffer (NEB)          ..............    10μL  
        Quick Ligase (NEB#M2200S)           ................    2μL  
        total                                                           ..........      22μL  

6. Transformation into Stbl3 bacteria.  
refer to: 2019-02-18-transformation-DNAextraction.md

## Materials

*  Plasmid and transfer DNA information
    -  backbone: SpCas9 Plasmid: Addgene, lentiCRISPR v2 (Plasmid #52961)
    -  target: oligos for sgRNA construction, 送公司合成(擎科，有康)

*  Plasmid and transfer DNA information
    -  backbone: SpCas9 Plasmid: Addgene, lentiCRISPR v2 (Plasmid #52961)
    -  target: oligos for sgRNA construction, 送公司合成(擎科，有康)

*  Basic requirements (medium and others....)   
    -  ddH2O: UltraPure DNase/RNase-free distilled water (Life Technologies, cat. no. 10977-023)
    -  Ampicillin, 100 mg ml−1, sterile filtered
    -  LB medium and agar medium
    -  DNA ladder, DM2000 (国产待填充)

* sgRNA oligo annealing
    -  T4 polynucleotide kinase (PNK) (New England BioLabs, cat. no. M0201S)
        +  Phosphorylation is the process by which phosphate groups are added to a molecule by a kinase. The phosphorylation status of a fragment of DNA can influence its ability to proceed in reactions.
        +  T4多核苷酸激酶(T4 PNK)催化 γ 磷酸从 ATP 转移到5'-OH 基团的单链和双链 dna 和 rna，寡核苷酸，或3'-单磷酸核苷(前向反应)。 这个反应是可逆的。 在 ADP 存在下，T4多核苷酸激酶具有5'-磷酸酶活性，并催化5'-磷酸寡核苷酸与 ATP 之间的磷酸基团交换(交换反应)。 这种酶也是一种3'-磷酸酶
        +  从 ATP 的位置到多核苷酸(双链和单链 DNA 和 RNA)和3- 核苷酸的5- 羟基末端。 多核苷酸激酶还催化去除3- 磷酰基多核苷酸、脱氧核苷 -3- 单磷酸和脱氧核苷 -3- 二磷酸(1)中的3- 磷酰基
    -  10x T4 DNA ligation buffer, 10× (New England BioLabs#B0202S) 有ATP
        +  70 mM Tris-HCl
        +  10 mM MgCl2
        +  5 mM DTT
        +  (pH 7.6 @ 25°C)
        +  Vector plasmid digest
    -  FastDigest BbsI (Esp3l) (Thermo#FD1014)
    -  FASTAP (Thermo#EF0651)：热敏碱性磷酸酶催化从 DNA、 RNA 和核苷酸中释放5'-和3'-磷酸基团。 这种酶还能去除蛋白质中的磷酸基团
        +  一种新型的碱性磷酸酶，在所有的 Thermo Scientific / 限制酶缓冲区和 PCR 缓冲区中都很活跃。 它能在37 °c 下10分钟内脱磷酸化所有类型的 DNA 末端(钝形、5'-和3'-悬垂)。 该酶在75 °c 下5分钟内失活连接前不需要切除碱性磷酸酶
    -  100nM DTT (Fermentas/Thermo Scientific, cat. no. R0862)
    -  10X FastDigest Buffer (Themo#B64)
        +  支持所有 FastDigest 限制酶的100% 活性。 Dna / rna 修饰酶，如连接酶、磷酸酶、激酶和中温 DNA 聚合酶在 FastDigest 缓冲液中也有100% 的活性。 因此，用于下游应用的酶可以直接添加到 FastDigest 反应混合物中
    -  QIAquick gel extraction kit (Qiagen, cat. no. 28704)

*  Ligation Reaction
    -  Quick Ligase (NEB#M2200S)
    -  2x Quick Ligase Buffer (NEB)
    -  Digested vector plasmid (100ng/rxn)

*  Transformation
    -  competent cell: NEB stable
    -  SOC Outgrowth Medium (refer to [medium preparation](https://github.com/hwoihann/bioinfo-basics/blob/master/materials/%E5%9F%B9%E5%85%BB%E5%9F%BA%E5%88%B6%E5%A4%87%E6%B1%87%E6%80%BB.md))
    -  QIAprep spin miniprep kit (Qiagen, cat. no. 27106)
    
*  REAGENT SETUP
    -  TAE electrophoresis solution: Dilute 50xTAE buffer in distilled water to a 1× working solution, and store it at room temperature (18–22 °C) for up to 6 months.
    -  DTT, 100 nM: Prepare the solution in ddH2O, divide it into aliquots and store them at −70 °C for up to 2 years. Use a new aliquot for each reaction, as DTT is easily oxidized.
        +  用于将 −SH 基保持在还原态的绝佳试剂；定量还原二硫化物。在 SDS-PAGE 前，DTT 在样品缓冲液中可有效还原蛋白二硫键。DTT 还可用于还原交联剂 N,N′-双(丙烯酰)胱胺的二硫键桥以分解聚丙烯酰胺凝胶基质。DTT 的刺激性和毒性都低于 2-巯基乙醇。通常，使用 DTT (100mM) 所需的浓度是使用 2-巯基乙醇 (5% v/v, 700mM) 的浓度的七分之一。

