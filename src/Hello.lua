-- CC_USE_DEPRECATED_API = true --
require "cocos.init"
require "ui"

-- cclog��Ϣ --
cclog = function(...)
    print(string.format(...))
end

-- ���½�OpenGl����Ϣ --
local function initGLView()
    local director = cc.Director:getInstance()
    local glView = director:getOpenGLView()
    if nil == glView then
        -- ���ڴ�С
        glView = cc.GLViewImpl:createWithRect("Aircraft War" ,cc.rect(0, 0, 640, 960))
        director:setOpenGLView(glView)
    end

    director:setOpenGLView(glView)

    -- ��Ʒֱ���
    glView:setDesignResolutionSize(640, 960, cc.ResolutionPolicy.NO_BORDER)

    -- ��FPS�Ŀ���
    director:setDisplayStats(true)

    --����FPS��Ĭ��ֵΪ1.0/60
    director:setAnimationInterval(1.0 / 60)
    --director:setFrameTime(true)
end


local function main()

    -- �����ڴ�й¶ --
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    -- ��ʼ��OpenGL --
    initGLView()

    -------------
    -- ��ʼ���� --
    -- �������� --
    -- local sceneGame = cc.Scene:create()
    -- -- �ѱ���ͼ�㺯�����뵽������
    -- sceneGame:addChild(ui.createLayerBackground())
    -- -- ���г���
    -- cc.Director:getInstance():runWithScene(sceneGame)    

    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(scene)
    -- ��ȡ�����µ��ӽڵ� -- 
    local children = scene:getChildren()
    local Canvas = children[2]

    --�����ܷ�������ȡ�ڵ����ֵ --
    Canvas:getChildByName("gamelabel"):setString("Aircraft War!")
    Canvas:getChildByName("button"):addClickEventListener(function()
        print("hewenning")
    end)

    -- ��ȡ��Ӣ�۾���Ľڵ� --
    local hero = Canvas:getChildByName("hero")

    -- �����µ�ͼ�� -- 
    local layer = cc.Layer:create()

    -- ��������¼� -- 
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

    -- ����ʱ��ʱ��鿴�ڵ��� --
    do
        local poco = require('poco.poco_manager')
        poco:init_server(15005)  -- default port number is 15004, change to another if you like
    end

end


main()


