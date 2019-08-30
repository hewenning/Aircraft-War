controller = {}

-- ���ݳ�ʼ�� -- 
function controller.initData()
    -- �����ÿ� --
    score.value = 0
    load.Canvas:getChildByName("label"):getChildByName("scorevalue"):setString(score.value)
    -- ���߳�ʼ�� --
    prop.bombnum = 5
    local bombnumlabel = load.Canvas:getChildByName("label"):getChildByName("bombnumlabel"):setString(prop.bombnum)
    -- �л����ӵ����� --
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

    -- Ӣ������ --
    for i, v in pairs(heroSet) do
        v:removeFromParent()
        heroSet[i] = nil
    end
    heroSet = {}

    -- ��ʱ����������0 --
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

-- ��ʾ������Ϣ�ĺ��������Է�װ���� --
function controller.infoDisplay(str)
    -- �����ļ� --
    local infoReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/propinfo.ccreator')
    local infoScene = infoReader:getSceneGraph()
    local infoNode = infoScene:getChildByName("info")
    infoNode:removeFromParent(false)
    -- ���ڴ������Ľڵ���д��� --
    load.Canvas:addChild(infoNode)
    -- infoNode:setPosition(node:getPositionX(), node:getPositionY())
    infoNode:setPosition(320, 700)
    infoNode:getChildByName("infolabel"):setString(str)

    -- ��ʾ����֮������ --
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