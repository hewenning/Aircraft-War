controller = {}

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

return controller