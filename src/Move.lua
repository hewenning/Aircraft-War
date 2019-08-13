move = {}

--用来处理英雄移动的函数 --
function move.doleft()
    print("come in left")
    load.hero:runAction(cc.MoveBy:create(0.25, cc.p(-50, 0)))
end

function move.doright()
    print("come in right")
    load.hero:runAction(cc.MoveBy:create(0.25, cc.p(50, 0)))
end

function move.doup()
    print("come in up")
    load.hero:runAction(cc.MoveBy:create(0.25, cc.p(0, 50)))
end

function move.dodown()
    print("come in down")
    load.hero:runAction(cc.MoveBy:create(0.25, cc.p(0, -50)))
end

return move