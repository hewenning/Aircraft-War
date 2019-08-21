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

    -- ����ģ�� --
    load.loadModel()
    
    -- ����������� --
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))

    -- ������ײϵͳ --
    -- controller.Collosion()

    -- ����ʱ��ʱ��鿴�ڵ��� --
    do
        local poco = require('poco.poco_manager')
        poco:init_server(15005)  -- default port number is 15004, change to another if you like
    end

end

main()

return hello

