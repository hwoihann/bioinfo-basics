# 感受态细胞制备

## 简介

## 1. 准备

### 1.1 Materials
1. 培养基相关：如何配？详见[培养基制备汇总](https://github.com/hwoihann/bioinfo-basics/blob/master/materials/%E5%9F%B9%E5%85%BB%E5%9F%BA%E5%88%B6%E5%A4%87%E6%B1%87%E6%80%BB.md)
    - SOB培养基
    - LB液体培养基
    - LB + 抗生素平板
    - 500 mL锥形瓶（配LB）
2. 制备用 
 - 专用的玻璃器皿或塑料容器100 mL锥形瓶（扩增摇菌时用）
 - 涂布棒（放烧杯用酒精浸润）
 - 酒精灯
 - 用于扩增的感受态大肠杆菌（-80℃ storage，一支100uL，一次性）
 - 制备试剂盒：TAKARA Competent Cell Preparation Kit No.9139
3. storage
 - 1.5mL离心管用于储存制备好的100uL感受态细胞
 - 摇菌管5mL, 15mL           


### 1.2 预演

时间控制：第一天扩增获得单克隆，第二天摇菌，第三天完成制备
     +  在LB+抗生素平板上划线或涂布分离培养，过夜
     +  挑单菌落，扩大培养
     +  OD600值在0.4～0.45之间适宜制备感受态

质量控制：
 - 用质粒检验评估感受态效率：准备高纯度的质粒DNA分装低温（-20 ℃）保存，用作阳性对照，以确认每批制的感受态细胞转化效率。
 - 体系变化：50ml ->  5ml -> 50*100uL

操作步骤注意：
 - 确保在超净台操作，打开酒精灯
 - 立即制备，不要长时间室温或冰上放置
 - 使用Solution A Solution B悬浮沉淀时要用手指轻弹动EP管壁，禁止剧烈振荡操作。
 - 不要用错枪的量程

## 2. 实操

1. 菌种纯化：Day1  
 + 使用LB/抗生素平板培养基（根据菌种性质加入适当的抗生素），用枪头挑取菌株（-70℃甘油保存菌），在平板上画线分离，以能够出现单菌落为宜。  也可以选择涂布  
 + 将平板倒置于恒温箱中37 ℃培养过夜    

2. 菌体培养：Day2  
 + 在超净台中，挑取过夜培养的画线分离的平板培养基上的两个单菌落，分别接种到 __两个__含有50 mL SOB培养基的500 mL锥形瓶中。
 + 37 ℃振荡（约120 rpm）培养。
 + 在超净台中，取适量菌液，测定OD600，当OD600达到0.4～0.45时（约培养5小时），则停止摇菌培养，进行下面感受态细胞的制备。如果OD600超出此范围则不能保证感受态细胞的转化效率。

3. 使用TAKARA试剂盒制作感受态细胞
 + 取出试剂盒A B溶液放于冰上 
 + 在超净台中，将上述OD达标的菌液转移到离心管中，配平  1,500×g（一般的微型离心机约4,000 rpm）4℃离心5分钟，弃上清（注意尽量除）。  
 + 超净台中，根据每1 mL菌液加入100 μl冰中预冷的Solution A的比例，加入Solution  A，轻轻弹动EP管，使菌体沉淀悬浮，__禁止剧烈振荡__ 
 + 1,500×g（一般的微型离心机约4,000 rpm）4℃离心5分钟，弃上清（注意尽量除）
 + 超净台中，根据每1 mL菌液加入100 μl冰中预冷的Solution B的比例，加入Solution  B，轻轻弹动EP管，使菌体沉淀悬浮，__禁止剧烈振荡__ 
 + 感受态细胞制作完成，分装每个1.5 mL EP管100uL感受态细胞。

预期结果：
 - 50mL菌液制备，可获得50个*100uL感受态管子,5mL产量
 - 感受态细胞可直接用于DNA转化，也可以于-80℃保存有效一年上，但不能反复冻融，一旦溶解后不能再进行 

>A typical 200mL bacterial culture produces 20mL of competent cells, enough for 800 transformations when using 25uL competent cells per reaction. We grow our cells in LB rather than the ZymoBrothTM, so it costs us less than 5 cents per transformation.


## 3. 参考
 1. Mix & Go E. coli Transformation Kit & Buffer Set Catalog Nos. T3001 & T3002
 2. https://openwetware.org/wiki/Preparing_chemically_competent_cells
 3. http://www.addgene.org/protocols/bacterial-transformation/
