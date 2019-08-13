-- CC_USE_DEPRECATED_API = true --
require "cocos.init"
require "keyboard"

hello = {hero = 1,}

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

    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(scene)
    -- 获取场景下的子节点 -- 
    local children = scene:getChildren()
    local Canvas = children[2]

    --测试能否正常获取节点的数值 --
    Canvas:getChildByName("gamelabel"):setString("Aircraft War!")

    --把键盘事件添加进场景
    scene:addChild(keyboard.getKeyBoardStatus())

    -- 获取到英雄精灵的节点 --
    local temp = Canvas:getChildByName("hero")
    hello.hero = temp

    -- 运行时的时候查看节点树 --
    do
        local poco = require('poco.poco_manager')
        poco:init_server(15005)  -- default port number is 15004, change to another if you like
    end


end
main()

return hello




