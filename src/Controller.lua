controller = {choseTag = 1,}

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

function controller.keySwitch()

    -----------------
    -- 游戏控制部分 --
    -----------------
    -- 选择界面 --
    if keyboard.keyStatus[6] == 1 then
        controller.Choose()
    end
    -- 继续游戏 --
    if keyboard.keyStatus[126] == 1 then
        controller.Resume()
    end
    -- 重新开始 --
    if keyboard.keyStatus[141] == 1 then
        controller.Reload()
    end
    -- 退出游戏 --
    if keyboard.keyStatus[140] == 1 then
        controller.Exit()
    end

    -----------------
    -- 道具控制部分 --
    -----------------
    -- 使用道具 --
    if keyboard.keyStatus[149] == 1 then
        prop.bombRelease()
    end

    -----------------
    -- 商城控制部分 --
    -----------------
    if keyboard.keyStatus[136] == 1 then
        -- mall.Choose()
        mall.ChooseAndResume()
    end

    -- -----------------
    -- -- 背包控制部分 --
    -- -----------------
    if keyboard.keyStatus[125] == 1 then
        bag.ChooseAndResume()
    end

    -- if keyboard.keyStatus[145] == 1 then
    --     bag.Resume()
    -- end

end

return controller