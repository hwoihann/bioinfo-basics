> Task description
>
> 1. 内容应包括技术的历史-原理-技术的应用以及与别的技术相比的缺陷（cas9 vs talen vs ZFN），如何避免脱靶，技术的应用在哪些实验上以及如何操作的详细protocol。
> 2. 以以一个蛋白atat1作为例子来具体化实验操作方案。比如：如何用cas9将atat1 KO，如何用Talen将atat1 KO，有哪些公共的database可以帮忙设计target片段，哪里可以买到所需耗材，实验室需要什么质粒系统，addgene上有没有可以买的质粒等。

## 一、基因编辑概述

### 1. 基因编辑类型

基因定点修饰操作本质上均是利用非同源末端链接途径（NHEJ）修复和同源重组（HR）修复，联合特异性DNA的靶向识别及核酸内切酶完成 的DNA序列改变，可以分为：

1. 敲入（knock in）
2. 敲除（knock out）:多重敲除（multiplex knockout）和条件敲除（conditional knockout）
3. 删失（deletion）
4. 基因融合（gene integration）

![img](http://pic.biodiscover.com/files/j/al/201405041550575991.jpg)

### 2. 两个问题

基因组编辑 (genome editing)  是一种人工靶向诱导基因组目标DNA序列发生突变的遗传工程。通过导入的**核酸酶**使DNA靶点发生双链DNA**断裂**，再经细胞内DNA修复系统在靶点**引入突变**。这一技术涉及两个问题：

1. 如何实现靶向？
2. 怎样产生双链DNA断裂（DSB）？

### 3. 四类技术

目前的技术都涉及到嵌合核酸酶的构建，主要由可编码的**序列特异性DNA结合模块**与**非特异性的DNA切割结构域**组成，通过诱导DNA双链断裂（DNA double-strand break, DSB）来刺激容易出错的非同源末端连接或在特定基因所在的位置进行的同源定向修复。按照时间发展顺序和普及程度排序，四类技术如下：
1. Meganuclease (罕见位点核酸酶)
2. ZFN (锌指核酸酶)
3. TALEN (转录激活因子样效应物核酸酶)
   - TAL效应因子（**TAL effector, TALE**）最初是在一种名为黄单胞菌（Xanthomonas sp.）的植物病原体中作为一种细菌感染植物的侵袭策略而被发现的。这些TALE通过细菌 III类分泌系统（bacterial type III secretion system）被注入植物细胞中，通过**靶定效应因子特异性的基因启动子**来调节转录，来促进细菌的集落形成。
   - 由于TALE具有序列特异性结合能力，研究者通过将**FokI核酸酶与一段人造TALE（基因）连接起来**，形成了一类具有特异性基因组编辑功能的强大工具，即TALEN。
   - 
4. CRISPR/Cas9 (规律性簇集间隔分布短回文重复序列)





当使用大范围核酸酶时，**难以清楚显示**核酸酶和DNA之间的位点专一识别 。ZFs和TALEs，已证明难以设计和识别DNA的**3个核苷酸**。作用像crRNAs的单个导向RNAs (sgRNAs) 容易设计，还能和Cas9核酸酶**在同一载体中一起表达**，针对特定DNA位点进行基因编辑。当用于筛选时， CRISPR/Cas 9系统比短发卡RNAs具有更高的**敏感性**和更**高效率**。



**keyword: site-specific** 

## 二、CRISPR/Cas

---

Clustered regularly interspaced short palindromic repeat, CRISPR（**成簇**的规律**间隔**的短回文**重复序列**）

不论是TALEN技术还是ZFN技术，其定向打靶都依赖于**DNA序列特异性结合蛋白模块的合成**，这一步骤非常繁琐费时。而CRISPR/Cas技术作为一种 最新涌现的基因组编辑工具，能够**完成RNA导向的DNA识别及编辑**。

> CRISPR/ CAS系统是一种细菌和古细菌用于外源遗传物质的降解的适应性免疫防御机制。在这些生物体中，来自噬菌体的外源遗传物质获得和整合入CRISPR位点 。这种新材料，也称为间隔区（spacer），建立用于将来对噬菌体感染性的序列特异性的片段。
>
> **自己注解：在序列一致性上，spacer=crRNA**

CRISPR/Cas 作为原核生物中普遍存在的一种系统，最初的功能就是**识别**外源性入侵的核酸序列，并对其进行**特异性降解**，以达到抗病毒的作用。这一过程分两步进行—— crRNA的合成及在crRNA引导下的RNA结合与剪切：

- **crRNA的生物学合成**

  CRISPR区域第一个重复序列上游有一段CRISPR的前导序列（Leader sequence），该序列作为启动子来启动后续CRISPR序列的转录，转录生成的RNA被命名为CRISPRRNA（简称crRNA）。

- **RNA的结合与剪切**

  CRISPR/Cas 系统中crRNA与tracrRNA（反式激活的crRNA）形成嵌合RNA分子，即单向导RNA（Single guide RNA,sgRNA）。sgRNA可以介导Cas9蛋白在特定序列处进行切割，形成DNA双链断裂（Double-Stranded Break, DSB），完成基因定向编辑等的各类操作。

优势：

优势：

- 1) 可用位置更多。理论上，在基因组中每8 bp就有一个适合CRISPR/Cas9编辑的位点（PAM），分布频率很高。而对于ZFN和TALEN，在基因组中平均分别要500 bp和125 bp才会有一个合适的编辑位点。
- 2) 可同时编辑多个位点。Wang等利用CRISPR/Cas9技术一次性构建了含5个突变位点转基因鼠；Zhou团队[10]也构建了同时包含3个突变位点的基因敲除大鼠，而且3基因同时敲除的效率高达59.1%。这对于ZFN和TALEN两项技术而言是难以实现的。
- 3) 识别域的构建更简单。在CRISPR/Cas9系统中，想要改变靶序列识别位点只需改变一段短的RNA序列即可。而ZFN和TALEN则需要根据不同的识别序列组装和构建十分复杂的蛋白识别域，费时费力，所以CRISPR/Cas9技术更容易得到推广和应用。





近年发展：2013年初的《科学》第339卷第6121期连载了两篇具有重要意义的CRISPR技术论 文，其中一篇描述的是麻省理工学院（Massachusetts Institute of Technology, MIT）Zhang的研究组使用CRISPR技术完成了多重基因组编辑；另一篇描述了哈佛医学院（Harvard Medical School）Church的研究组首次使用CRISPR技术完成了RNA介导的人类基因组编辑



**keyword: gRNA引导核酸内切酶**

### 1. 组件说明

---

CRISPR/Cas系统由CRISPR序列元件与Cas基因家族组成：

- 其中CRISPR由一系列高度保守的重复序列（repeat）与同样高度保守的间隔序列（spacer）相间排列组成。
- 而在CRISPR附近区域还存在着一部分高度保守的**CRISPR相关基因**（CRISPR-associated gene, Cas gene），这些基因编码的蛋白具有**核酸酶活性的功能域**，可以对DNA序列进行特异性的切割。



CRISPR/Cas系统根据分类有三种，其共同特点是都具有DNA区域、靶向crRNA和PAM（前间区序列邻近基序）。其中CRISPR/Cas9系统主要是产脓链球菌来源，PAM位点为NGG:

Cas9核酸酶具有RNA结合域，α螺旋识别叶（REC），核酸叶，其中包括RuvC和HNH的DNA裂解和 前间区序列邻近基序（PAM）交叉位点。 

1. crRNA形成与Cas9核酸酶的复合通过结合到REC叶内桥螺旋，并形成多个具有crRNA骨干的盐桥 。一旦crRNA结合到Cas9，Cas9核酸酶的构象发生改变，产生一条能通道，让DNA更容易结合。

2. Cas9/crRNA复合体扫描DNA**找到PAM (5'-NGG)位点**。识别PAM位点导致DNA**解旋**，使crRNA找到PAM位点相邻的DNA互补链。
   - 当Cas9结合到PAM位点相邻的，与crRNA互补的DNA序列上，REC叶内部的桥螺旋和靶DNA**形成RNA-DNA 异源双链结构**。PAM位点的识别包括可使靶DNA双链断裂(DSB)的HNH和RuvC核断裂的激活，和导致DNA降解。
   - 如果crRNA与靶DNA不互补，Cas9将会释放出来，寻找新的PAM位点。
3. DNA中的线性靶基因组断裂后可以通过非同源末端接合(NHEJ)或者同源介导的修复(HDR)来进行修复。



**CRISPR-associated gene, Cas gene**

#### 1.1. CRISPR序列

CRISPR作为一种特殊的DNA重复序列，主要由多段长度25−50 bp的高度保守的**重复片段**和26−72 bp长度的**间隔片段间隔**串联而成。对重复片段的结构分析发现，其序列存在二重对称性，即可以形成发夹结构

#### 1.2. Cas家族蛋白







ref: 

1. https://www.scbt.com/scbt/zh/whats-new/crispr-systems
2. CRISPR/Cas9介导的基因编辑技术研究进展
3. https://slidesplayer.com/slide/11500221/




### 2. 工具清单

#### 2.1. sgRNA靶点设计网站

参考：http://www.addgene.org/crispr/reference/

[ZiFiT](http://zifit. partners.org/ZiFiT/)：ZFN、TALEN、CRISPR/Cas9靶位点设计

http:// www.genome-engineering.org/：不仅可以在用户指定的碱基序列中搜索靶位点，而且还支持人、小鼠、斑马鱼以及线虫等十几种模式生物基因组的在线比对，并列举出各个靶点潜在的脱靶位点，让用户更理性地选择靶位点。





#### 2.2. 试剂订购

- sigma aldrich: [CAS9 Protein](https://www.sigmaaldrich.com/catalog/product/sigma/cas9prot?lang=zh&region=CN)

![0115-001-shutter](/home/whh/Pictures/shutter2018/0115-001-shutter.png)

---

参考

1. http://journals.im.ac.cn/html/cjbcn/2015/11/gc15111531.htm

### 3. 实验checkpoint

根据上述原理，只需通过人工合成方法定制crRNA将其插入到合适的质粒中，与分别表达的tracrRNA和Cas9蛋白的质粒共转染细胞，或体外转录成RNA注射到细胞中就可以建立基因敲除细胞系。大致步骤：

1. 确定待敲除基因的靶点
2. 设计识别靶位点的sgRNA序列，合成一对序列互补的Oligo DNA
3. 构建可表达的质粒
4. sgRNA活性检测
5. 利用cas9质粒构建KO细胞系



用sgRNA做KO的步骤大致是这样的吗？
1. 找到对应的蛋白质，比如tet3的sgRNA位点
2. 

## 三、TALEN

通过 DNA识别模块将TALEN元件靶向特异性的DNA位点并结合，然后在FokI核酸酶的作用 下完成特定位点的剪切，并借助于细胞内固有 的**同源定向修复（HDR）或非同源末端连接 途径（NHEJ）修复过程**完成特定序列的插入 （或倒置）、删失及基因融合（校正）



> 参考文献
>
> 1. Thomas Gaj, Charles A. Gersbach, and Carlos F. Barbas III. (2013) ZFN, TALEN, and CRISPR/Cas-based methods for genome engineering. Trends in Biotechnology, 31(7): 397-405.



### 1. 组件说明

TALE：

- 每一个独立的TALE重复序列元件包含33到35个氨基酸残基，这些TALE重复序列元件能够通过两个高变异度的残基（即重复可变双残基，RVD，棍状显示）来识别一个单一的碱基对。
- TALEN目标位点由**两个TALE结合位点**组成，这两个位点间通过不同长度的间隔区序列（12-20bp）分开。

TALE组成结构：

- N端结构域：2核定位信号（Nuclear localization signal, NLS）
- 中央结构域：可识别特定 DNA序列的典型串联TALE重复序列的
- C端结构域：具有FokI核酸内切酶功能

TAL的DNA特异性识别单位是间隔32个恒定氨基酸残基的二联氨基酸，二联氨基酸与AGCT这4个核苷酸碱基有一一对应的关系：腺嘌呤（A）由NI识别、胸腺嘧啶（T）由NG识别、鸟嘌呤（G）由NN识别，而胞嘧啶（C）则由HD识别。实验操作中，我们通过 靶位点的DNA序列可以反推能特异性识别这一序列的二联氨基酸序列，从而构建TAL靶点识别模块。

TALEN元件识别的特异性DNA序列长度区别：

- 天然的TALEN元件识别的特异性DNA序列长度一般为17-18bp
- 而人工TALEN元件识别的特异性DNA序列长度则一般为14-20bp

TALEN质粒的结构优化

- 
- 2014年2月，北京大学生命科学学院魏文胜课题组依托于一种自主研发的TALE蛋白组装技术（ULtiMATE system）完成了全部 TALE元件的解码工作



## 四、ZFN

由**锌指DNA结合域**（zinc finger DNA-binding domain）与**限制性内切酶的DNA切割域**（DNA cleavage domain）融合而成

- 锌指DNA结合域部分一般包含**3个独立的锌指（Zinc finger, ZF）重复结构**，**每个锌指结构能够识别3个碱基**，因而一个锌指DNA结合域可以识别9bp长度的特异性序列（而ZFN二聚体，则包含6个锌指，可以识别18bp长度的特异性序列）。



发展

- 早期的 ZFN技术一般采用普通的 FokI-ZFN二聚体形式来保证其切割效率，但使用过程中可能因同**源二聚体效应（homodimerization）**而导致脱靶，影响切割特异性。

缺陷

- ZFN对DNA的剪切需要两个FokI切割区域的二聚化，并且需要至少一个识别单元结合DNA。
- DNA识别域虽然具 有较强的特异性识别能力，但由于ZFN剪切的过程并不完全依赖同源二聚体的形成，所以一旦形成异源二聚体，就很可能造成脱靶效应，并最终可能导致DNA的 错配和序列改变，产生较强的细胞毒性。
- ZFN作为基因治疗的手段之一，如果在生物体内使用，可能会引发免疫反应。







---

## 习题部分



### 名词解释

1. [同源介导修复（HDR）](https://www.scbt.com/scbt/zh/resources/protocols/crispr-cas9-ko-plasmid-and-hdr-plasmid-transfection)
2. 基因编辑种类
3. 慢病毒包装