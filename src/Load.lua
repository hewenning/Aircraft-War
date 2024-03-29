load = {hero = 1, Canvas = 1, heroBox = 1, loadCanvas = 1,}

function load.loadUI()

    local creatorReaderLoad = creator.CreatorReader:createWithFilename('Resources/creator/Scene/loading.ccreator')
    creatorReaderLoad:setup()
    local sceneStart = creatorReaderLoad:getSceneGraph()

    cc.Director:getInstance():replaceScene(sceneStart)
    -- 获取场景下的节点 -- 
    local children = sceneStart:getChildren()
    load.loadCanvas = children[2]

    -- 在精灵上加载动画 --
    local sprite = load.loadCanvas:getChildByName("load")

    -- 利用精灵帧缓存所有的图片 --
    cc.SpriteFrameCache:getInstance():addSpriteFrames("plist/load.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("plist/alienA.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("plist/alienB.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("plist/alienC.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("plist/bombAction.plist")

    -- 加载动画 --
    local loadActionFrame = cc.Animation:create()
    local nameLoad 
    for i = 1, 4 do
        nameLoad = "load"..i..".png"
        loadActionFrame:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(nameLoad))
    end
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

    -- 测试英雄类 --
    local heroObject = Hero.new(0, 0)
    table.insert(heroSet, heroObject)


    -------------------
    -- 启动调度器设置 --
    -------------------
    -- schedule.setup()
    gamelogic.setup()

    -------------------
    -- 添加菜单的按钮 --
    -------------------
    menu.mainButton()

end

return load