load = {hero = 1,}

function load.loadModel()

    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(scene)
    -- 获取场景下的节点 -- 
    local children = scene:getChildren()
    local Canvas = children[2]

    ------------------
    -- 键盘控制飞机  --
    ------------------
    --把键盘事件添加进场景
    scene:addChild(keyboard.getKeyBoardStatus())
    -- 获取到英雄精灵的节点 --
    local temp = Canvas:getChildByName("hero")
    load.hero = temp

    -------------------
    -- 获取到标签节点 --
    -------------------
    -- Canvas:getChildByName("gamelabel"):setString("")    
    local label = Canvas:getChildByName("label")
    local gamelabel = label:getChildByName("gamelabel")
    gamelabel:setString("")

    -- 打开英雄节点的默认调度器 --
    load.hero:scheduleUpdateWithPriorityLua(move.update, 0)

end

return load