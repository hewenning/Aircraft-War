-- CC_USE_DEPRECATED_API = true --
require "cocos.init"
require "keyboard"
require "load"
require "bullet"
require "alien"
require "hit"
require "controller"
require "score"
require "gameover"
require "archive"
require "prop"
require "mall"
require "bag"
require "menu"
require "hero"
require "gamelogic"


-- cclog信息 --
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
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

    -- 加载最开始界面 --
    load.loadUI()
    
    -- 加载游戏界面 --
    --load.loadGame()

    -- 传入随机种子 --
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))

    -- 运行时的时候查看节点树 --
    do
        local poco = require('poco.poco_manager')
        poco:init_server(15005)  -- default port number is 15004, change to another if you like
    end

end

xpcall(main, __G__TRACKBACK__)
-- main()

return hello

