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
    backgroundEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(backgroundMove, 0.01,false)
end

return schedule