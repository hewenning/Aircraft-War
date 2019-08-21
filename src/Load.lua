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
    loadActionFrame:setDelayPerUnit(6 / 4)
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

    controller.PauesAndResume()
    -- 暂停游戏和恢复游戏和退出游戏 --
    -- cc.Director.sharedDirector():pause()
    -- cc.Director.sharedDirector():resume()
    -- cc.Director:sharedDirector():endToLua()
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
    -- local label = load.Canvas:getChildByName("label")
    -- local gamelabel = label:getChildByName("gamelabel")
    -- gamelabel:setString("")

    -------------------
    -- 启动调度器设置 --
    -------------------
    schedule.setup()


end

return load