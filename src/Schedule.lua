schedule = {}

function schedule.setup()

    ---------------------
    -- ���ڱ����ĵ����� --
    --------------------- 
    local background1 = load.Canvas:getChildByName("background1")
    local background2 = load.Canvas:getChildByName("background2")
    -- ��������ˢ�º��� --
	local function backgroundMove()
		background1:setPositionY(background1:getPositionY()-2)
		background2:setPositionY(background1:getPositionY() + background1:getContentSize().height - 2)
		if background2:getPositionY() == 480 then
			background1:setPositionY(0)
		end
    end
    -- �򿪱����ĵ����� -- 
    schedule.backgroundEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(backgroundMove, 1/60, false)

    -- ���ӵ��ĵ����� --
    schedule.bulletEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(bullet.createBullet, 0.08, false)
  
    -- �����л�AB��C�ĵ����� -- 
    schedule.alienAEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.createA, 1, false)
    schedule.alienBEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.createB, 3, false)
    schedule.alienCEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(alien.createC, 10, false)

    -- �����ӵ��͵л���ײ�ĵ����� --
    schedule.hitEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(hit.checkBulletToAlien, 1/60, false)
    
    -- ����Ӣ�ۺ͵л���ײ�ĵ����� --
    schedule.hitHeroEntry = CCDirector:getInstance():getScheduler():scheduleScriptFunc(hit.checkAlienToHero, 0.5, false)

    -- Ӣ�۵ĵ����� --
    --schedule.heroMove = CCDirector:getInstance():getScheduler():scheduleScriptFunc(move.update, 1/60, false)
    -- �ӵ��ɳ���Ļ������ --
    schedule.destoryOutBullet = CCDirector:getInstance():getScheduler():scheduleScriptFunc(bullet.destoryOutBullet, 1, false)
    -- �ɻ��ɳ���Ļ������ --
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