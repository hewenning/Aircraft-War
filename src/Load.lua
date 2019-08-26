require "schedule"

load = {hero = 1, Canvas =1, heroBox = 1,}

function load.loadUI()

    local creatorReaderLoad = creator.CreatorReader:createWithFilename('Resources/creator/Scene/loading.ccreator')
    creatorReaderLoad:setup()
    local sceneStart = creatorReaderLoad:getSceneGraph()

    cc.Director:getInstance():replaceScene(sceneStart)
    -- 获取场景下的节点 -- 
    local children = sceneStart:getChildren()
    load.Canvas = children[2]

    -- 在精灵上加载动画 --
    local sprite = load.Canvas:getChildByName("load")

    -- 加载动画 --
    local loadActionFrame = cc.Animation:create()
    local nameLoad 
    for i = 1, 4 do
        nameLoad = "load/load"..i..".png"
        loadActionFrame:addSpriteFrameWithFile(nameLoad)
    end
    -- Should last 1 second. And there are 5 frames.
    loadActionFrame:setDelayPerUnit(2 / 4)
    loadActionFrame:setRestoreOriginalFrame(true)
    local loadAction = cc.Animate:create(loadActionFrame)
    
    local LoadAndSwitch = cc.Sequence:create( 
                {   
                    loadAction,
                    cc.CallFunc:create( function()
                        load.loadGame()
                        print("Start new game.")
                    end ),          
                }
            )
    sprite:runAction(LoadAndSwitch)

end

function load.loadGame()
    
    local creatorReaderStart = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReaderStart:setup()
    local scene = creatorReaderStart:getSceneGraph()
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


    -------------------
    -- 启动调度器设置 --
    -------------------
    schedule.setup()

    -------------------
    -- 添加菜单的按钮 --
    -------------------
    menu.mainButton()

end

return load