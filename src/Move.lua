move = {}

--用来处理英雄移动的函数 --
function move.doleft()
    print("come in left")
    load.hero:runAction(cc.MoveBy:create(0.1, cc.p(-8, 0)))
end

function move.doright()
    print("come in right")
    load.hero:runAction(cc.MoveBy:create(0.1, cc.p(8, 0)))
end

function move.doup()
    print("come in up")
    load.hero:runAction(cc.MoveBy:create(0.1, cc.p(0, 8)))
end

function move.dodown()
    print("come in down")
    load.hero:runAction(cc.MoveBy:create(0.1, cc.p(0, -8)))
end


-- 更新英雄行为的函数 -- 
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