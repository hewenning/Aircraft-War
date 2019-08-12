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

    -- ��������¼� -- 

    -- ����ʱ��ʱ��鿴�ڵ��� --
    do
        local poco = require('poco.poco_manager')
        poco:init_server(15005)  -- default port number is 15004, change to another if you like
    end

end


main()


