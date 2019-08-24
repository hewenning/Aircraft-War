controller = {choseTag = 1,}

-- ѡ����� --
function controller.Choose()

    cc.Director.sharedDirector():pause()
    local controller = creator.CreatorReader:createWithFilename('Resources/creator/Scene/controller.ccreator')
    controller:setup()
    local sceneController = controller:getSceneGraph()
    local controlground = sceneController:getChildByName("controlground")
    controlground:removeFromParent(false)
    load.Canvas:addChild(controlground)

end

-- ������Ϸ --
function controller.Resume()
    load.Canvas:getChildByName("controlground"):removeFromParent()
    cc.Director.sharedDirector():resume()
end

-- ���¿�ʼ --
function controller.Reload()
    load.Canvas:getChildByName("controlground"):removeFromParent()
    cc.Director.sharedDirector():resume()
    controller.initData()
end

-- �˳���Ϸ --
function controller.Exit()
    cc.Director.sharedDirector():endToLua()
end

-- ���ݳ�ʼ�� -- 
function controller.initData()
    -- �����ÿ� --
    score.value = 0
    load.Canvas:getChildByName("label"):getChildByName("scorevalue"):setString(score.value)
    -- Ѫ������ -- 
    hero.hp = 100
    -- ����ֵ���� --
    hero.life = 5
    load.Canvas:getChildByName("label"):getChildByName("lifevalue"):setString(hero.life)
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
end

function controller.keySwitch()

    -----------------
    -- ��Ϸ���Ʋ��� --
    -----------------
    -- ѡ����� --
    if keyboard.keyStatus[6] == 1 then
        controller.Choose()
    end
    -- ������Ϸ --
    if keyboard.keyStatus[126] == 1 then
        controller.Resume()
    end
    -- ���¿�ʼ --
    if keyboard.keyStatus[141] == 1 then
        controller.Reload()
    end
    -- �˳���Ϸ --
    if keyboard.keyStatus[140] == 1 then
        controller.Exit()
    end

    -----------------
    -- ���߿��Ʋ��� --
    -----------------
    -- ʹ�õ��� --
    if keyboard.keyStatus[149] == 1 then
        prop.bombRelease()
    end

    -----------------
    -- �̳ǿ��Ʋ��� --
    -----------------
    if keyboard.keyStatus[136] == 1 then
        -- mall.Choose()
        mall.ChooseAndResume()
    end

    -- -----------------
    -- -- �������Ʋ��� --
    -- -----------------
    if keyboard.keyStatus[125] == 1 then
        bag.ChooseAndResume()
    end

    -- if keyboard.keyStatus[145] == 1 then
    --     bag.Resume()
    -- end

end

return controller