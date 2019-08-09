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
        glView = cc.GLViewImpl:createWithRect("2048" ,cc.rect(0, 0, 960, 640))
        director:setOpenGLView(glView)
    end

    director:setOpenGLView(glView)

    -- 设计分辨率
    glView:setDesignResolutionSize(960, 640, cc.ResolutionPolicy.NO_BORDER)

    -- 打开FPS的开关
    director:setDisplayStats(false)

    --设置FPS，默认值为1.0/60
    director:setAnimationInterval(1.0 / 60)
end



local function main()

    -- 避免内存泄露 --
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    -- 初始化OpenGL --
    initGLView()

    ---------------
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


    do
        local poco = require('poco.poco_manager')
        poco:init_server(15005)  -- default port number is 15004, change to another if you like
    end


end


main()


