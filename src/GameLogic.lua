gamelogic = {TimerA = 0, TimerB =0, TimerC =0, TimerBullet = 0,}
-------------------
-- 调度器有关设置 --
-------------------
function gamelogic.backgroundScroll()
    local background1 = load.Canvas:getChildByName("background1")
    local background2 = load.Canvas:getChildByName("background2")
    -- 背景滚动刷新函数 --
    background1:setPositionY(background1:getPositionY()-2)
    background2:setPositionY(background1:getPositionY() + background1:getContentSize().height - 2)
    if background2:getPositionY() == 480 then
        background1:setPositionY(0)
    end
end


-- 子弹创建和销毁 --
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

-- 敌机创建和销毁 --
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

-- 每一帧都更新，在这里执行整个游戏的逻辑 --
function gamelogic.processlogic()
    -- 更新背景 --
    gamelogic.backgroundScroll()
    -- 英雄移动 --
    heroSet[1]:update()
    -- 在这里不断的创建敌机 --
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
    -- 处理子弹的创建 --
    gamelogic.TimerBullet = gamelogic.TimerBullet + 1
    if gamelogic.TimerBullet == 6 then
        gamelogic.createBullet()
        gamelogic.TimerBullet = 0    
    end    
    -- 处理子弹和敌机的碰撞事件 -- 
    hit.checkBulletToAlien()
    hit.checkAlienToHero() 
    -- 子弹和英雄销毁 --
    gamelogic.destoryOutBullet()
    gamelogic.destoryOutAlien()
end

function gamelogic.setup()
    gamelogic.gamelogicSchedule = CCDirector:getInstance():getScheduler():scheduleScriptFunc(gamelogic.processlogic, 1/60, false)
end

function gamelogic.shutdown()
    CCDirector:getInstance():getScheduler():unscheduleScriptEntry(gamelogic.gamelogicSchedule)
end

return gamelogic