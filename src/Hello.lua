-- CC_USE_DEPRECATED_API = true --
require "cocos.init"
require "ui"

-- cclog信息 --
cclog = function(...)
    print(string.format(...))
end

-- 左下角OpenGl的信息 --
local function initGLView()
    local director = cc.Director:getInstance()
    local glView = director:getOpenGLView()
    if nil == glView then
        -- 窗口大小
        glView = cc.GLViewImpl:createWithRect("Aircraft War" ,cc.rect(0, 0, 640, 960))
        director:setOpenGLView(glView)
    end

    director:setOpenGLView(glView)

    -- 设计分辨率
    glView:setDesignResolutionSize(640, 960, cc.ResolutionPolicy.NO_BORDER)

    -- 打开FPS的开关
    director:setDisplayStats(true)

    --设置FPS，默认值为1.0/60
    director:setAnimationInterval(1.0 / 60)
    --director:setFrameTime(true)
end


local function main()

    -- 避免内存泄露 --
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    -- 初始化OpenGL --
    initGLView()

    -------------
    -- 开始运行 --
    -- 创建场景 --
    -- local sceneGame = cc.Scene:create()
    -- -- 把背景图层函数加入到场景下
    -- sceneGame:addChild(ui.createLayerBackground())
    -- -- 运行场景
    -- cc.Director:getInstance():runWithScene(sceneGame)    

    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(scene)
    -- 获取场景下的子节点 -- 
    local children = scene:getChildren()
    local Canvas = children[2]

    --测试能否正常获取节点的数值 --
    Canvas:getChildByName("gamelabel"):setString("Aircraft War!")
    Canvas:getChildByName("button"):addClickEventListener(function()
        print("hewenning")
    end)

    -- 获取到英雄精灵的节点 --
    local hero = Canvas:getChildByName("hero")

    -- 创建新的图层 -- 
    local layer = cc.Layer:create()

    -- 加入键盘事件 -- 
    local function onKeyPressed(keyCode, event)
        local buf = string.format("%d DOWN", keyCode)
        local node = event:getCurrentTarget()
        print(buf)
    end
 
    local function onKeyReleased(keyCode, event)
        local buf = string.format("%d UP", keyCode)
        local node = event:getCurrentTarget()
        print(buf)
    end
 
    local statusLabel = cc.Label:createWithSystemFont("NO EVENT", "Arial", 25)
    statusLabel:setPosition(100, 100)
    layer:addChild(statusLabel)

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
 
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)

    scene:addChild(layer)

    -- 运行时的时候查看节点树 --
    do
        local poco = require('poco.poco_manager')
        poco:init_server(15005)  -- default port number is 15004, change to another if you like
    end

end


main()


