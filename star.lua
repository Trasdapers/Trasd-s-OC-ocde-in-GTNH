--[[
坠星自动化--OC电脑脚本部分
GTNH版本：2.6.1（注:旧版本不兼容，该版本采矿机会自动回收，旧版本需要加上采矿后的完成关闭函数）
由Trasd编写---2024.8.10
注：需保证lp和电力供应充足，本脚本仅内置机器活动状态检测（可供检测电力和钻井液问题）
]]--
local component = require("component")
local os=require("os")
local sides = require("sides")
local gt_machine={}  --存储采矿机地址--
--[[
--绝对方向--
东(E):sides.east    南(S):sides.south
西(W):sides.west    北(N):sides.north
上:sides.up         下:sides.down
--相对方向--
前:sides.front      后:sides.back
左:sides.left       右:sides.right
上:sides.up         下:sides.down
注:相对方向是相对于红石组件的。正对机器时，前后左右与其相反。
]]--
--配置部分--
local redstone_active_side=sides.front  --(相对方向)采矿激活面在红石组件的方向(红石组件("红石I/O端口"/"基础红石卡"))--
local redstone_occupy_side=sides.back --(相对方向)采矿反馈面。采矿完成,采矿机空闲后将会持续激活--
local redstone_claern_side=sides.left  --(相对方向)岩石清理激活面--
local wait_time1=10 --采矿机激活信号侦测间隔(影响消息刷屏速度)--
local wait_time2=120 --采矿机完成情况侦测间隔(影响消息刷屏速度)--
local clearn_time =1200  --采石机清理时长(不宜过短)--
--配置部分--

function Get_address(gt_machine)--获取采矿机地址--
  local n = 1
  for i,j in pairs(component.list()) do
     if(j=="gt_machine")then
        print("发现机器(find host):",i,j)
        gt_machine[n]=i
        n=n+1
     end
   end
end

function Wait_redstone(redstone_active_side,wait_time1)--等待采矿机激活信号--
  while component.redstone.getInput(redstone_active_side) == 0 do
     print("采矿机等待激活中...(wait...)")
     os.sleep(wait_time1)  --等待--
  end
end

function Active_gt(gt_machine,redstone_occupy_side) --激活采矿机--
  component.redstone.setOutput(redstone_occupy_side,15)  --开启采矿机占用信号--
  for i,j in pairs(gt_machine) do
    local gt=component.proxy(j)
    gt.setWorkAllowed(true)
    print("激活机器(active host):",i,j)
  end
end

function State_gt(gt_machine)--机器活动状况检测--
  local state=0
  while(state==0) do
    os.sleep(5)
    state = 1
    for i,j in pairs(gt_machine) do
      local gt=component.proxy(j)
      if(gt.isWorkAllowed()==false) then
        state=0
        print("机器运行出现故障，请手动维护")
      end
      os.sleep(10)  --等待--
    end
  end
  print("机器运行正常")
end
function Wait_finish(gt_machine,wait_time2,redstone_occupy_side)--采矿任务完成情况侦测--
  local task=0
  while(task==0) do
    print("采矿任务完成中")
    task = 1
    for i,j in pairs(gt_machine) do
      local gt=component.proxy(j)
      if(gt.isWorkAllowed()==true) then
        task=0;
      end
    end
    os.sleep(wait_time2)  --等待--
  end
  print("采矿任务已完成")  
end

function Clearn(redstone_claern_side,clearn_time,redstone_occupy_side)  --岩石清理--
  component.redstone.setOutput(redstone_claern_side,15)  --激活采石机信号--
  print("开始岩石清理")
  os.sleep(clearn_time)
  component.redstone.setOutput(redstone_claern_side,0)  --关闭采石机信号--
  os.sleep(3)
  component.redstone.setOutput(redstone_occupy_side,0)  --关闭采矿机占用信号--
  print("清理完成")
end

function main()
  Get_address(gt_machine)
  while true do
    Wait_redstone(redstone_active_side,wait_time1)   --等待激活--
    Active_gt(gt_machine,redstone_occupy_side) --激活采矿机--
    State_gt(gt_machine)--机器活动状况检测--
    os.sleep(60)
    Wait_finish(gt_machine,wait_time2,redstone_occupy_side)  --采矿任务完成情况侦测--
    Clearn(redstone_claern_side,clearn_time)  --岩石清理--
  end
end

main()  --程序在此运行