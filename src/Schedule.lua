schedule = {}

function schedule.setup()

    ---------------------
    -- 关于背景的调度器 --
    --------------------- 
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
    schedule.bulletEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(bullet.createBullet, 0.08, false)
  
    -- 创建敌机AB和C的调度器 -- 
    schedule.alienAEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.createA, 1, false)
    schedule.alienBEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.createB, 3, false)
    schedule.alienCEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.createC, 10, false)

    -- 创建子弹和敌机碰撞的调度器 --
    schedule.hitEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(hit.checkBulletToAlien, 1/60, false)
    
    -- 创建英雄和敌机碰撞的调度器 --
    schedule.hitHeroEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(hit.checkAlienToHero, 0.5, false)

    -- 英雄的调度器 --
    --schedule.heroMove = CCDirector:getInstance():getScheduler():scheduleScriptFunc(move.update, 1/60, false)
    -- 子弹飞出屏幕即销毁 --
    schedule.destoryOutBullet = CCDirector:getInstance():getScheduler():scheduleScriptFunc(bullet.destoryOutBullet, 1, false)
    -- 飞机飞出屏幕即销毁 --
    schedule.destoryOutAlien = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.destoryOutAlien, 1, false)

end

function schedule.shutdown()   
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.backgroundEntry)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.backgroundEntry)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.bulletEntry)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.alienAEntry)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.alienBEntry)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.alienCEntry)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.hitEntry)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.hitHeroEntry)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.destoryOutBullet)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedule.destoryOutAlien)
end

return schedule