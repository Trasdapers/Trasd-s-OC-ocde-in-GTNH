--[[
坠星自动化--OC机器人脚本部分
GTNH版本：2.6.1（注:旧版本不兼容，该版本采矿机会自动回收，旧版本需要加上采矿后的完成关闭函数）
由Trasd编写---2024.8.10
注：需保证lp和电力供应充足,一般采矿时间远大于lp补充所需时间，故本机器人脚本仅设置一个仪式是否正常启动检测以防万一。
]]--
local component = require("component")
local os=require("os")
local sides = require("sides")
robot=require("robot")
--[[
--绝对方向--
东(E):sides.east    南(S):sides.south
西(W):sides.west    北(N):sides.north
上:sides.up         下:sides.down
--相对方向(不推荐使用)--
前:sides.front      后:sides.back
左:sides.left       右:sides.right
上:sides.up         下:sides.down
注:相对方向是相对于机器人的。正对机器时，前后左右与其相反。
机器人箱子图标面为背面。
]]--
--配置部分--
local redstone_occupy_side=sides.front   -- 该面判断采矿场是否被占用(被占用为激活状态)--
local redstone_active_side=sides.back  -- 该面输出oc电脑所需的采矿场激活信号--
local wait_time1=120  --采矿场占用等待时间(不宜过短)--
local active_time=60  --采矿场激活信号持续时间(不宜过短)--
local find_time=60  --机器人寻找物品间隔(不宜过短)--
local ritual_time=60 --仪式激活失败后，再次激活间隔--
local throw_time=60 --仪式激活成功后，抛掷等待时间(为补齐激活仪式所消耗lp，防止极限lp任务导致坠星失败)--
local fall_time=20  --陨石降落等待时间--
local main_time=60 --主程序循环时间--
--配置部分--

local location_item=1 --坠星任务物品所在插槽索引--

function Is_occupy(redstone_occupy_side,wait_time1) --判断采矿场是否被占用--
  while component.redstone.getInput(redstone_occupy_side) == 15 do
     print("采矿机被占用中...(occuping...)")
     os.sleep(wait_time1)  --等待--
  end
  os.sleep(1)
end

function Find_item(location_item,find_time)  --寻找坠星任务物品所在插槽索引--
  while(robot.count(location_item)==0) do
    if(location_item==16) then  --插槽索引超限保护--
      print("目前无坠星任务")
      os.sleep(find_time)
      location_item=0
    end
    location_item=location_item+1
  end
  print("发现坠星任务物品，插槽数为：",location_item)
  os.sleep(1)
  robot.select(location_item)
end

function Active_ritual(ritual_time,throw_time)  --激活仪式--
  while(robot.useDown(0)==false) do  --激活仪式并侦测是否激活成功--
    print("仪式激活失败，请检查仪式结构完整性和lp存量是否足够")
    os.sleep(ritual_time)
  end
    print("仪式激活成功")
  os.sleep(throw_time)
end

function Throw_item(redstone_active_side,fall_time,active_time)  --坠星任务物品投掷,并释放采矿场激活信号--
  robot.dropDown(1)
  print("抛物已完成")
  os.sleep(fall_time)
  component.redstone.setOutput(redstone_active_side,15)  --释放采矿场激活信号--
  os.sleep(active_time)
  component.redstone.setOutput(redstone_active_side,0)  --关闭采矿场激活信号--
end

function main(main_time)  --主程序--
  while true do
    Is_occupy(redstone_occupy_side,wait_time1)
    Find_item(location_item,find_time)
    Active_ritual(ritual_time,throw_time)
    Throw_item(redstone_active_side,location_item,fall_time,active_time)
    os.sleep(main_time)
  end
end

main(main_time) --程序在此运行--
