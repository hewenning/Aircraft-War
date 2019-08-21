-- CC_USE_DEPRECATED_API = true --
require "cocos.init"
require "keyboard"
require "load"
require "bullet"
require "alien"
require "hit"
require "controller"
require "score"
require "hero"

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

    -- 加载模型 --
    load.loadModel()
    
    -- 传入随机种子 --
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))

    -- 开启碰撞系统 --
    -- controller.Collosion()

    -- 运行时的时候查看节点树 --
    do
        local poco = require('poco.poco_manager')
        poco:init_server(15005)  -- default port number is 15004, change to another if you like
    end

end

main()

return hello

