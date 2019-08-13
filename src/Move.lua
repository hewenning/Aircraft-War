

move = {}

--用来处理英雄移动的函数 --
function move.doleft()
    print("come in left")
    -- local moveBy = cc.MoveBy:create(0.1, Vec2(-50, 0))
    -- hello.hero.runAction(cc.moveBy(0.25, Vec2(-50, 0)))
    hello.hero:runAction(cc.MoveBy:create(0.25, cc.p(-50, 0)))
end

function move.doright()
    print("come in right")
    hello.hero:runAction(cc.MoveBy:create(0.25, cc.p(50, 0)))
end

function move.doup()
    print("come in up")
    hello.hero:runAction(cc.MoveBy:create(0.25, cc.p(0, 50)))
end

function move.dodown()
    print("come in down")
    hello.hero:runAction(cc.MoveBy:create(0.25, cc.p(0, -50)))
end

return move