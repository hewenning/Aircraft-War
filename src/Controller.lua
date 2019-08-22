controller = {}

-- 选择界面 --
function controller.Choose()

    cc.Director.sharedDirector():pause()
    local controller = creator.CreatorReader:createWithFilename('Resources/creator/Scene/controller.ccreator')
    controller:setup()
    local sceneController = controller:getSceneGraph()
    local controlground = sceneController:getChildByName("controlground")
    controlground:removeFromParent(false)
    load.Canvas:addChild(controlground)

end

-- 继续游戏 --
function controller.Resume()
    load.Canvas:getChildByName("controlground"):removeFromParent()
    cc.Director.sharedDirector():resume()
end

-- 重新开始 --
function controller.Reload()
    load.Canvas:getChildByName("controlground"):removeFromParent()
    cc.Director.sharedDirector():resume()
    controller.initData()
end

-- 退出游戏 --
function controller.Exit()
    cc.Director.sharedDirector():endToLua()
end

-- 数据初始化 -- 
function controller.initData()
    -- 分数置空 --
    score.value = 0
    load.Canvas:getChildByName("label"):getChildByName("scorevalue"):setString(score.value)
    -- 血量加满 -- 
    hero.hp = 100
    -- 生命值加满 --
    hero.life = 5
    load.Canvas:getChildByName("label"):getChildByName("lifevalue"):setString(hero.life)
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
end

return controller