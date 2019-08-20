schedule = {}

function schedule.setup()
    -- 打开英雄节点的默认调度器 --
    load.hero:scheduleUpdateWithPriorityLua(move.update, 0)

    local background1 = load.Canvas:getChildByName("background1")
    local background2 = load.Canvas:getChildByName("background2")
    -- 背景滚动刷新函数 --
	local function backgroundMove()
		background1:setPositionY(background1:getPositionY()-2)
		background2:setPositionY(background1:getPositionY() + background1:getContentSize().height - 2)
		if background2:getPositionY() == 480 then
			background1:setPositionY(0)
		end
    end
    -- 打开背景的调度器 -- 
    backgroundEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(backgroundMove, 1/60, false)

    -- 打开子弹的调度器 --
    bulletEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(bullet.update, 0.08, false)
  
    -- 创建敌机AB和C的调度器 -- 
    alienAEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.updateA, 1, false)
    alienBEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.updateB, 3, false)
    alienCEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.updateC, 0.5, false)

    -- 创建子弹和敌机碰撞的定时器 --
    hitEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(hit.update, 1/60, false)

end

return schedule