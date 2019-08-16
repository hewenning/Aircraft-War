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
    backgroundEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(backgroundMove, 1/60, false)

    -- 打开子弹的调度器 --
    bulletEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(bullet.update, 0.08, false)

    -- 销毁已经执行完动画的子弹--
    -- bulletDestory = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(bullet.checkBulletAndRemove, 0.08, false)
    
    -- 创建敌机A的调度器 -- 
    --alienAEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(alien.updateA, 1, false)

end

return schedule