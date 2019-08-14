require "move"

keyboard = {keyStatus = {},}


function keyboard.getKeyBoardStatus()
    -- 创建新的图层 -- 
    local layer = cc.Layer:create()

    -- 加入键盘事件 -- 
    local function onKeyPressed(keyCode, event)
        local buf = string.format("%d DOWN", keyCode)
        keyboard.keyStatus[keyCode] = 1
        print(buf)
    end
 
    local function onKeyReleased(keyCode, event)

        -- local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bullet.ccreator')
        -- creatorReader:setup()
        -- local node = creatorReader:getSceneGraph():getChildByName("content")
        -- node:removeFromParentAndCleanup(false);
        -- node:setPosition(cc.p(300,200));        
        -- cc.Director:getInstance():getRunningScene():addChild(node);
        keyboard.keyStatus[keyCode] = 0
        local buf = string.format("%d UP", keyCode)
        print(buf)
    end

    -- 注册键盘监听事件--
    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)

    -- 返回图层 --
    return layer
end

return keyboard