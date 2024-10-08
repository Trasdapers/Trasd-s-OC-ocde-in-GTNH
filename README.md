![location](https://github.com/user-attachments/assets/ac0d8c9f-38f4-4abf-876d-fdbcbe84c320)# Trasd-s-OC-ocde-in-GTNH
Some OC code written while playing
There are OC files stored here, which are related to GTNH2.6.1.
这里存储着一些GTNH整合包相关的OC自动化脚本
GTNH版本为：2.6.1
目前只存储了血魔法坠星标位仪式相关的自动化脚本

# 坠星标位(Mark of the Falling Tower)
相关文件:robot.lua 和star.lua  
务必保证电力供应和lp供应以及红石传输的可靠性  
## 获取方法
### 使用因特网卡下载   
网址为:  
https://github.com/Trasdapers/Trasd-s-OC-ocde-in-GTNH/blob/oc/robot.lua (机器人部分)  
https://github.com/Trasdapers/Trasd-s-OC-ocde-in-GTNH/blob/oc/star.lua (OC电脑部分)
### 使用复制粘贴

## 用法
### 机器人部分
机器人必要组件（物品栏升级，物品栏交互升级，红石卡,T1显卡,T1显示屏，内存，CPU，硬盘等）  
相关方块:  
1.无线传输的红石(用于传输采矿激活，矿机占用 红石信号)
2.机器人充电器  
机器人放置于主仪式石上一格，手拿觉醒仪式激活石，  
仪式抛掷物品塞入机器人物品栏，也可管道导入。  
#### 相关配置 
见robot.lua，主要进行面(side)相关配置

### OC电脑部分
电脑必要组件(红石卡/红石组件，T1显卡，T1显示屏,内存,CPU,硬盘等)  
相关方块：
1.无线传输的红石(用于传输采矿激活，矿机占用以及岩石清理 红石信号)
2.电池箱(能源储备，可有可无，有供应即可)  
3.适配器(用MFU绑定采矿机或采矿场或直接接触采矿机/采矿场主控制方块面）（注意MFU距离有限） 
4.BC建筑机(负责采矿后进行岩石清理)  
5.金质管道(承载金质与门--红石信号激活  循环  红石信号无  关闭 ）  
#### 相关配置
见star.lua，主要进行面(side)相关配置，其次需要关注岩石清理时间（clearn_time）。

### 其他部分
坠点控制（坠点应高于仪式点30格，硬度应为-1程度，可用神秘核心：守护右键方块/放置守卫者方块 达到该效果）  
BC采矿场(总范围应包含坠点为中心 向外扩张25格的正方体范围，可拆分为8个采矿机范围进行，也可降低数量，但主要更改岩石清理时间）  
采矿机部分(放置在正方体区域上方，不涉及坠点所在3*3区域即可，数量任意，采矿范围能涵盖整个陨石即可，但必须全部用适配器接触或用适配器+MFU连接)  
注：需要在采矿机下方50-63格内放置卡位方块（硬度-1），及时将采矿管道卡住，不然会一直往下伸，或是因为采矿管道不够多而暂停运作，目前建议控制在下方50-63格，采石机范围之外的位置，这样采矿场里只用放一组采矿管道，不用外加。
### 相关参考图片
机器人  
![image](https://github.com/Trasdapers/Trasd-s-OC-ocde-in-GTNH/blob/oc/picture/robot.png)  
OC电脑  
![image](https://github.com/Trasdapers/Trasd-s-OC-ocde-in-GTNH/blob/oc/picture/star.png)  
采矿场以及BC建筑机  
![image](https://github.com/Trasdapers/Trasd-s-OC-ocde-in-GTNH/blob/oc/picture/BC.png)  
![image](https://github.com/Trasdapers/Trasd-s-OC-ocde-in-GTNH/blob/oc/picture/BC2.png)  
![image](https://github.com/Trasdapers/Trasd-s-OC-ocde-in-GTNH/blob/oc/picture/BC4.png)  
金质与门  
![image](https://github.com/Trasdapers/Trasd-s-OC-ocde-in-GTNH/blob/oc/picture/BC3.png)  




