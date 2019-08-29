gamelogic = {}
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
    -- 在这里不断的创建敌机 --
    gamelogic.createA()
    gamelogic.createB()
    gamelogic.createC()
    -- 处理子弹类别的创建和销毁 --
    gamelogic.createBullet()
    -- 处理子弹和敌机的碰撞事件 -- 
    hit.checkBulletToAlien()
    -- 处理子弹和英雄的碰撞事件 --
    hit.checkAlienToHero()
    -- 子弹销毁 --
    gamelogic.destoryOutBullet()
    -- 敌机销毁 --
    gamelogic.destoryOutAlien()
end

function gamelogic.setup()
    gamelogic.gamelogicSchedule = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(gamelogic.processlogic, 1/60, false)
end

function gamelogic.shutdown()
    CCDirector:sharedDirector():getScheduler():unscheduleScriptFunc(gamelogic.processlogic)
end

return gamelogic