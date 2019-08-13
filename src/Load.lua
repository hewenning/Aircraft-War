load = {hero = 1,}

function load.loadModel()

    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(scene)
    -- 获取场景下的节点 -- 
    local children = scene:getChildren()
    local Canvas = children[2]

    --测试能否正常获取节点的数值 --
    Canvas:getChildByName("gamelabel"):setString("")

    --把键盘事件添加进场景
    scene:addChild(keyboard.getKeyBoardStatus())

    -- 获取到英雄精灵的节点 --
    local temp = Canvas:getChildByName("hero")
    load.hero = temp

end

return load