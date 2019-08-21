require "schedule"

load = {hero = 1, Canvas =1, heroBox = 1,}

function load.loadModel()

    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(scene)
    -- 获取场景下的节点 -- 
    local children = scene:getChildren()
    load.Canvas = children[2]

    ------------------
    -- 键盘控制飞机  --
    ------------------
    --把键盘事件添加进场景
    scene:addChild(keyboard.getKeyBoardStatus())
    -- 获取到英雄精灵的节点 --
    local temp = load.Canvas:getChildByName("hero")
    load.hero = temp
    -- 英雄的节点 --
    -- load.heroBox = load.hero:getBoundingBox() 
    -- print(load.heroBox.x, load.heroBox.y, load.heroBox.width, load.heroBox.height)
    --local fire = load.hero:getChildByName("fireleft")
    -- fire:setStartColor({255, 0, 0, 0})
    -- fire:setEndColor({255, 0, 0, 0})
    
    
    -------------------
    -- 获取到标签节点 --
    -------------------
    -- Canvas:getChildByName("gamelabel"):setString("")    
    local label = load.Canvas:getChildByName("label")
    local gamelabel = label:getChildByName("gamelabel")
    gamelabel:setString("")

    -------------------
    -- 启动调度器设置 --
    -------------------
    schedule.setup()

end

return load