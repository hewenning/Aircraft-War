gamelogic = {TimerA = 0, TimerB =0, TimerC =0,}
-------------------
-- �������й����� --
-------------------
function gamelogic.backgroundScroll()
    local background1 = load.Canvas:getChildByName("background1")
    local background2 = load.Canvas:getChildByName("background2")
    -- ��������ˢ�º��� --
    background1:setPositionY(background1:getPositionY()-2)
    background2:setPositionY(background1:getPositionY() + background1:getContentSize().height - 2)
    if background2:getPositionY() == 480 then
        background1:setPositionY(0)
    end
end


-- �ӵ����������� --
function gamelogic.createBullet()
    if keyboard.keyStatus[59] == 1 or keyboard.keyStatus[164] == 1 then
        local newbullet = Bullet.new(0, 0)
        newbullet:getBullet()
        newbullet:play()
        table.insert(bullet.set, newbullet)
    end
end
function gamelogic.destoryOutBullet()
    for i, k in pairs(bullet.set) do
        if k:getPositionY() >= 500 then
            k:removeFromParent()
            bullet.set[i] = nil
        end
    end
end

-- �л����������� --
function gamelogic.createA()
    local alienA = Alien.new(alien.alienAPath, alien.A, 1, 5)
    alienA:randomPosition()
    alienA:getAlien()
    alienA:play()
    table.insert(alien.set, alienA)
end
function gamelogic.createB()
    local alienB = Alien.new(alien.alienBPath, alien.B, 3, 10)
    alienB:randomPosition()
    alienB:getAlien()
    alienB:play()
    table.insert(alien.set, alienB) 
end
function gamelogic.createC()
    local alienC = Alien.new(alien.alienCPath, alien.C, 10, 15)
    alienC:randomPosition()
    alienC:getAlien()
    alienC:play()
    table.insert(alien.set, alienC)
end
function gamelogic.destoryOutAlien()
    for i,v in pairs(alien.set) do
        if v:getPositionY() <= -600 then
            v:removeFromParent()
            alien.set[i] = nil
        end
    end
end

-- ÿһ֡�����£�������ִ��������Ϸ���߼� --
function gamelogic.processlogic()
    -- ���±��� --
    gamelogic.backgroundScroll()
    
    -- �����ﲻ�ϵĴ����л� --
    gamelogic.TimerA = gamelogic.TimerA + 1
    gamelogic.TimerB = gamelogic.TimerB + 1
    gamelogic.TimerC = gamelogic.TimerC + 1
    if gamelogic.TimerA == 60 then
        gamelogic.createA()
        gamelogic.TimerA = 0
    end
    if gamelogic.TimerB == 180 then
        gamelogic.createB()
        gamelogic.TimerB = 0
    end
    if gamelogic.TimerC == 600 then
        gamelogic.createC()
        gamelogic.TimerC = 0
    end
    
    -- �����ӵ����Ĵ��������� --
    gamelogic.createBullet()
    
    -- �����ӵ��͵л�����ײ�¼� -- 
    hit.checkBulletToAlien()
    
    -- �����ӵ���Ӣ�۵���ײ�¼� --
    hit.checkAlienToHero()
    -- �ӵ����� --
    gamelogic.destoryOutBullet()
    
    -- �л����� --
    gamelogic.destoryOutAlien()
end

function gamelogic.setup()
    gamelogic.gamelogicSchedule = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(gamelogic.processlogic, 1/60, false)
end

function gamelogic.shutdown()
    CCDirector:sharedDirector():getScheduler():unscheduleScriptFunc(gamelogic.processlogic)
end

return gamelogic