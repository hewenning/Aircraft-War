controller = {}

-- 数据初始化 -- 
function controller.initData()
    -- 分数置空 --
    score.value = 0
    load.Canvas:getChildByName("label"):getChildByName("scorevalue"):setString(score.value)
    -- 道具初始化 --
    prop.bombnum = 5
    local bombnumlabel = load.Canvas:getChildByName("label"):getChildByName("bombnumlabel"):setString(prop.bombnum)
    -- 敌机和子弹销毁 --
    for _, i  in pairs(alien.set) do
        i:removeFromParent()
    end
    for _, k in pairs(bullet.set) do
        k:removeFromParent()
    end
    alien.set = {}
    alien.Tag = 0
    bullet.set = {}
    bullet.Tag = 0

    -- 英雄销毁 --
    for i, v in pairs(heroSet) do
        v:removeFromParent()
        heroSet[i] = nil
    end
    heroSet = {}

    -- 定时器计数器置0 --
    gamelogic.TimerA = 0
    gamelogic.TimerB = 0
    gamelogic.TimerC = 0
    gamelogic.TimerBullet = 0
end

function controller.keySwitch()
    if keyboard.keyStatus[149] == 1 then
        prop.bombRelease()
    end
end

function controller.setBulletAndAlienPause()
    -- schedule.shutdown()
    gamelogic.shutdown()
    for _, k in pairs(alien.set) do
        k:pause()
    end
    for _, v in pairs(bullet.set) do
        v:pause()
    end
    heroSet[1]:pause()
end

function controller.setBulletAndAlienResume()
    --schedule.setup()
    gamelogic.setup()
    for _, k in pairs(alien.set) do
        k:resume()

    end
    for _, v in pairs(bullet.set) do
        v:resume()	

    end
    heroSet[1]:resume()
end

-- 显示道具信息的函数，可以封装成类 --
function controller.infoDisplay(str)
    -- 加载文件 --
    local infoReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/propinfo.ccreator')
    local infoScene = infoReader:getSceneGraph()
    local infoNode = infoScene:getChildByName("info")
    infoNode:removeFromParent(false)
    -- 对于传进来的节点进行处理 --
    load.Canvas:addChild(infoNode)
    -- infoNode:setPosition(node:getPositionX(), node:getPositionY())
    infoNode:setPosition(320, 700)
    infoNode:getChildByName("infolabel"):setString(str)

    -- 显示三秒之后销毁 --
    local sequence = cc.Sequence:create( 
        {
            cc.MoveBy:create(1.5, cc.p(0, 0)),
            cc.CallFunc:create( function()
                infoNode:removeFromParent()
                print("The info has been cleared.")    
            end ),          
        }
    )
    infoNode:runAction(sequence)

end

return controller