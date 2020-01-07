# 感受态细胞质粒DNA转化和提取 
Bacterial Transformation and Plasmid Extraction


## 2019-03-25 更新

Reagents
 * LB agar plate (with appropriate antibiotic)
 * LB or SOC media
 * Competent cells
 * DNA you'd like to transform

Procedure: 

 1. Take competent cells out of -80°C and thaw on ice (approximately 20-30 mins).

 2. Remove agar plates (containing the appropriate antibiotic) from storage at 4°C and let warm up to room temperature and then (optional) incubate in 37°C incubator.

 3. Mix 1 - 5 μl of DNA (usually 10 pg - 100 ng) into 20-50 μL of competent cells in a microcentrifuge or falcon tube. GENTLY mix by flicking the bottom of the tube with your finger a few times.
    *Pro-Tip* Transformation efficiencies will be approximately 10-fold lower for ligation of inserts to vectors than for an intact control plasmid.  

 4. Incubate the competent cell/DNA mixture on ice for 10 mins.
  For maximum transformation efficiency, cells and DNA should be incubated together on ice for 30 minutes. Expect a 2-fold loss in transformation efficiency for every 10 minutes this step is shortened. 

  5, Heat shock each transformation tube 42°C water bath for 90s
  3. 
Put the tubes back on ice for 5 min, don't move
  4. 
Add 250-1,000 μl LB or SOC media (without antibiotic) to the bacteria and grow in 37°C shaking incubator for 50 min.

    * 
Expect a 2-fold loss in transformation efficiency for every 15 minutes this step is shortened. SOC gives 2-fold higher transformation efficiency than LB medium; and incubation with shaking or rotating the tube gives 2-fold higher transformation efficiency than incubation without shaking.
    * 
*Pro-Tip* 为什么不加抗性培养基：This outgrowth step allows the bacteria time to generate the antibiotic resistance proteins encoded in the plasmid backbone so that they will be able to grow once plated on the antibiotic containing agar plate. This step is not critical for Ampicillin resistance but is much more important for other antibiotic resistances.


  1. 
Plate some (circle) or all (digested vector) of the transformation onto a 10 cm LB agar platecontaining the appropriate antibiotic.


*Pro-Tip* 用量 We recommend that you plate 50 μL on one plate and the rest on a second plate. This gives the best chance of getting single colonies, while allowing you to recover all transformants.
*Pro-Tip* 干燥的重要性 If the culture volume is too big, gently collect the cells by centrifugation and resuspend in a smaller volume of LB so that there isn't too much liquid media on the agar plates. If the agar plate doesn't dry adequately before the cells begin dividing, the bacteria diffuse through the liquid and won't grow in colonies.
  1. 
Incubate plates at 37°C overnight. Check the efficiency, inspect the plates for colony growth. 


For sgRNA cloing vector:.....
Typically, there are no colonies on the negative control plates (ligation of BbsI-digested pSpCas9(BB) alone without annealed sgRNA oligo insert), and there are tens to hundreds of colonies on the pSpCas9(sgRNA) (sgRNA inserted into pSpCas9(BB)) cloning plates.
From each plate, pick two or three colonies to check for the correct insertion of sgRNA. Use a sterile pipette tip to inoculate a single colony into a 3-ml culture of LB medium with 100 μg ml−1 ampicillin. Incubate the culture and shake it at 37 °C overnight.
Day 3: isolate the plasmid DNA from cultures by using a QIAprep spin miniprep kit according to the manufacturer's instructions.



## 太长不看版

材料准备
1. 培养基
    - 抗生素平板
    - 有SOC用SOC, 没有SOC 用SOB 
2. 制备用 
 - 冰盒
 - 42°C 热激heater + 90s调好的timer
 - 专用的玻璃器皿或塑料容器100 mL锥形瓶（扩增摇菌时用）
 - 涂布棒（放烧杯用酒精浸润）
 - 酒精灯
 - 感受态细胞（-80℃ storage，一支100uL，一次性）
 - 制备试剂盒：QIAGEN miniprep spin 2.0，[handbook](https://www.qiagen.com/us/resources/resourcedetail?id=22df6325-9579-4aa0-819c-788f73d81a09&lang=en)
3. storage
 - 1.5mL EP管
 - 摇菌管5mL         


Day1感受态转化  
 1. 将感受态细胞于-80℃中拿出，置于冰中融化10 min
 2.在超净台中，向感受态细胞中加入10ng转化用的DNA（~1μl)，轻轻混匀后冰中放置30分钟。
 3. 42℃水浴中放置90秒钟（热激）后，立即于冰中放置5分钟，不要摇动EP管。
 4. 在超净台中，加入500 μl 37℃预热的SOB/SOC培养基。
 5. 37℃振荡培养1小时，220 rpm，复苏。
 6. 在超净台中，适当稀释后取适量涂于特定抗性平板后，将平板正置直到液体被吸收。
     - 此步可以加对照，如特定抗性的质粒
 7. 将平板倒置，37℃培养箱过夜。
 
Day2  
8. 确认菌落，进行下步操作。摇菌，扩大培养小抽：
 + 超净台酒精灯旁操作，将5 uL抗生素（100 mg/mL）加入到含有__5mL无菌LB培养基__的试管内，挑菌棒蘸取或枪头挑起单克隆菌落打入试管中，37℃振荡培养过夜，200 rpm

Day3 
9. QIAGEN Miniprep Kit 小抽    获得DNA
10. (extra) 需要Midiprep的话，继续用8中的菌液振荡过夜：  

## Intro

注意细节和trouble shooting需要参考:
https://www.addgene.org/protocols/bacterial-transformation/?gclid=Cj0KCQiAh9njBRCYARIsALJhQkFOABU93QVR9iLjlH7Wr_7gGtUcjbGBrMqxqzMQXqiQYm_thlA6AWkaAsyHEALw_wcB


Transformation is the process by which foreign DNA is introduced into a cell. 
 usage: storing and replicating plasmids. Because of this, nearly all plasmids (even those designed for mammalian cell expression) carry both a bacterial origin of replication and an antibiotic resistance gene for use as a selectable marker in bacteria.

转化是将外源 DNA 引入细胞的过程。 质粒转化细菌用途：存储和复制质粒的手段。
几乎所有的质粒(包括哺乳动物细胞表达质粒)都携带一个__细菌复制原点__和一个__抗生素抗药性基因__，用作细菌中的选择标记。

科学家们进行了许多基因修饰，以创造出更容易转化的细菌菌株，这将有助于在不重排质粒 DNA 的情况下质粒活性。 此外，还发现了一些特殊的处理方法，可以提高转化效率，使细菌更容易受到转化的影响，从而产生通常所说的competent cell，那么如何制作感受态细胞？
 - addgene的[How to Make Your Own Competent Cells](https://blog.addgene.org/save-time-and-money-by-making-your-own-competent-cells?_ga=2.215151511.1095503737.1551324736-1260308651.1551061627&_gac=1.226015720.1551324736.Cj0KCQiAh9njBRCYARIsALJhQkFOABU93QVR9iLjlH7Wr_7gGtUcjbGBrMqxqzMQXqiQYm_thlA6AWkaAsyHEALw_wcB)
 - [自己的感受态细胞制备protocol](https://github.com/hwoihann/bioinfo-basics/blob/master/protocol/2019-02-19-competent-cell-prepareation.md)
 - [openwetware](https://openwetware.org/wiki/Transforming_chemically_competent_cells)

## 大致步骤
 
### 1. 准备
!!! 首先需要准备好测完浓度的质粒DNA
   + 假如是切胶回收的DNA连接产物，全部转化!!!
   + 假如是质粒DNA10ng 即可，1μl of prepped plasmid is more than enough

#### 1.1 Materials
1. 培养基相关：如何配？详见[培养基制备汇总](https://github.com/hwoihann/bioinfo-basics/blob/master/materials/%E5%9F%B9%E5%85%BB%E5%9F%BA%E5%88%B6%E5%A4%87%E6%B1%87%E6%80%BB.md)
    - 抗生素平板
    - 有SOC用SOC, 没有SOC 用SOB 
2. 制备用 
 - 冰盒
 - 42°C 热激heater + 90s调好的timer
 - 专用的玻璃器皿或塑料容器100 mL锥形瓶（扩增摇菌时用）
 - 涂布棒（放烧杯用酒精浸润）
 - 酒精灯
 - 感受态细胞（-80℃ storage，一支100uL，一次性）
 - 制备试剂盒：QIAGEN miniprep spin 2.0，[handbook](https://www.qiagen.com/us/resources/resourcedetail?id=22df6325-9579-4aa0-819c-788f73d81a09&lang=en)
3. storage
 - 1.5mL EP管
 - 摇菌管5mL         

### 1.2 预演

备注：using SOC instead of LB + 20mM glucose increased efficiency 3 fold

## 2. 实操中文版

Day1感受态转化  
 1. 将感受态细胞于-80℃中拿出，置于冰中融化10 min
 2.在超净台中，向感受态细胞中加入转化用的DNA(~1μl)，轻轻混匀后冰中放置10分钟。
   + If you are adding small volumes (~1μl), be careful to mix the culture well. Diluting the plasmid back into a larger volume can also help.
 3. 42℃水浴中放置90秒钟（热激）后，立即于冰中放置5分钟，不要摇动EP管。
 4. 在超净台中，加入500 μl 37℃预热的SOB/SOC培养基。
 5. 37℃振荡培养1小时，220 rpm，复苏。
 6. 在超净台中，适当稀释后取适量涂于特定抗性平板后，将平板正置直到液体被吸收。
     - 此步可以加对照，如特定抗性的质粒
 7. 将平板倒置，37℃培养箱过夜。
 
Day2  扩增和小抽
8. 确认菌落，进行下步操作。摇菌，扩大培养小抽：
 + 超净台酒精灯旁操作，将5 uL抗生素（100 mg/mL）加入到含有__5mL无菌LB培养基__的试管内，挑菌棒蘸取或枪头挑起单克隆菌落打入试管中，37℃振荡培养过夜，200 rpm

__获得的菌液可以4 C°存一周，或者可以直接-80°C冻存，要用的时候再提__

Save the rest of the transformants in liquid culture at 4 °C. If nothing appears on your plate, you can spin this down, resuspend in enough medium to spread on one plate and plate it all. This way you will find even small numbers of transformants.

Day3 
9. 根据QIAGEN Miniprep Kit 小抽    获得DNA

10. (extra) 需要Midiprep的话，继续用8中的菌液振荡过夜：  
超净台中，将抗生素（100 mg/mL）加入含无菌LB培养基的锥形瓶内（每mL培养基加1  uL抗生素）,取小抽的菌液500 uL加入锥形瓶中，塞上棉塞，37℃振荡培养过夜，200 rpm


## 实操英文版

### Procedure
  1. Transfer the required number of tubes from -80°C freezer to wet ice. Include an extra tube for control DNA. 
  2. Thaw cells for 10 minutes. Gently tap the tubes multiple times.
  3. Add 0.1-10ng (3uL~10uL) of purified plasmid DNA directly to cells in rest of the tubes. Mix by gentle tapping and place on ice.
  Note: For control: Add 1µL (10ng) pUC19 control DNA to one tube. Mix by gentle tapping and place on ice.    
  4. Incubate the cells on ice for 10 minutes. 
  5. Transfer the cells to 42°C water bath for exactly 90 seconds.
  6. Immediately transfer the cells to ice for 5 minutes.
  7. Add 1mL LB medium to each tube. Transfer the cells to sterile polypropylene tubes and loosen the caps to facilitate aeration of the cultures.
  8. Incubates the cells on shaker incubator (225-250 rpm) at 37°C for 1 hour.
  9. Pipette 10-100µL of each transformed cell suspension onto LB agar plates with selection antibiotic and spread it using sterile spreader.
  10. Incubate plates at 37°C overnight.
  11. Select colony (colonies) and culture as needed.


Reference: https://www.addgene.org/protocols/bacterial-transformation/?gclid=Cj0KCQiAh9njBRCYARIsALJhQkFOABU93QVR9iLjlH7Wr_7gGtUcjbGBrMqxqzMQXqiQYm_thlA6AWkaAsyHEALw_wcB
