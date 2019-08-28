move = {}

--用来处理英雄移动的函数 --
function move.doleft()
    -- print("----------------------------------------------------")
    -- print("come in left")
    -- print(load.hero:getPositionX(), load.hero:getPositionY())
    -- print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
    -- print("----------------------------------------------------")
    -- load.hero:runAction(cc.MoveBy:create(0.1, cc.p(-5, 0)))
    if load.hero:getPositionX() > 60 then
        load.hero:runAction(cc.MoveBy:create(0.1, cc.p(-6, 0)))  
    elseif load.hero:getPositionX() <= 60 then
        load.hero:runAction(cc.MoveTo:create(0.01, cc.p(60, load.hero:getPositionY())))
    end
end

function move.doright()
    -- print("----------------------------------------------------")
    -- print("come in right")
    -- print(load.hero:getPositionX(), load.hero:getPositionY())
    -- print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
    -- print("----------------------------------------------------")
    -- load.hero:runAction(cc.MoveBy:create(0.1, cc.p(5, 0)))
    if load.hero:getPositionX() < 580 then
        load.hero:runAction(cc.MoveBy:create(0.1, cc.p(6, 0)))  
    elseif load.hero:getPositionX() >= 580 then
        load.hero:runAction(cc.MoveTo:create(0.01, cc.p(580, load.hero:getPositionY())))
    end
end

function move.doup()
    -- print("----------------------------------------------------")
    -- print("come in up")
    -- print(load.hero:getPositionX(), load.hero:getPositionY())
    -- print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
    -- print("----------------------------------------------------")
    -- load.hero:runAction(cc.MoveBy:create(0.1, cc.p(0, 5)))
    if load.hero:getPositionY() < 900 then
        load.hero:runAction(cc.MoveBy:create(0.1, cc.p(0, 6)))  
    elseif load.hero:getPositionX() >= 900 then
        load.hero:runAction(cc.MoveTo:create(0.01, cc.p(load.hero:getPositionX(), 900)))
    end
end

function move.dodown()
    -- print("----------------------------------------------------")
    -- print("come in down")
    -- print(load.hero:getPositionX(), load.hero:getPositionY())
    -- print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
    -- print("----------------------------------------------------")
    -- load.hero:runAction(cc.MoveBy:create(0.1, cc.p(0, -5)))
    if load.hero:getPositionY() > 180 then
        load.hero:runAction(cc.MoveBy:create(0.1, cc.p(0, -6)))  
    elseif load.hero:getPositionX() <= 180 then
        load.hero:runAction(cc.MoveTo:create(0.01, cc.p(load.hero:getPositionX(), 180)))
    end
end


-- -- 更新英雄行为的函数 -- 
function move.update()
    if keyboard.keyStatus[26] == 1 or keyboard.keyStatus[124] == 1 then
        move.doleft()
    elseif keyboard.keyStatus[27] == 1 or keyboard.keyStatus[127] == 1 then
        move.doright()
    elseif keyboard.keyStatus[28] == 1 or keyboard.keyStatus[146] == 1 then
        move.doup()
    elseif keyboard.keyStatus[29] == 1 or keyboard.keyStatus[142] == 1 then
        move.dodown()
    end
end



return move