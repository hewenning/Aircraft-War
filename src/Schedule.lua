schedule = {}

function schedule.setup()

    -- controller.initData()
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
    schedule.backgroundEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(backgroundMove, 1/60, false)

    -- 打开子弹的调度器 --
    schedule.bulletEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(bullet.update, 0.08, false)
  
    -- 创建敌机AB和C的调度器 -- 
    schedule.alienAEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.updateA, 1, false)
    schedule.alienBEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.updateB, 3, false)
    schedule.alienCEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.updateC, 10, false)

    -- 创建子弹和敌机碰撞的调度器 --
    schedule.hitEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(hit.checkBulletToAlien, 1/60, false)
    
    -- 创建英雄和敌机碰撞的调度器 --
    schedule.hitHeroEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(hit.checkAlienToHero, 0.5, false)


end


return schedule