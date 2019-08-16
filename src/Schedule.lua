schedule = {}

function schedule.setup()
    -- ��Ӣ�۽ڵ��Ĭ�ϵ����� --
    load.hero:scheduleUpdateWithPriorityLua(move.update, 0)

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
    backgroundEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(backgroundMove, 1/60, false)

    -- ���ӵ��ĵ����� --
    bulletEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(bullet.update, 0.08, false)

    -- �����Ѿ�ִ���궯�����ӵ�--
    -- bulletDestory = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(bullet.checkBulletAndRemove, 0.08, false)
    
    -- �����л�A�ĵ����� -- 
    --alienAEntry = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(alien.updateA, 1, false)

end

return schedule