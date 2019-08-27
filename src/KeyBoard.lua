require "move"


keyboard = {keyStatus = {},}


function keyboard.getKeyBoardStatus()
    -- 创建新的图层 -- 
    local layer = cc.Layer:create()

    -- 加入键盘事件 -- 
    local function onKeyPressed(keyCode, event)
        keyboard.keyStatus[keyCode] = 1
        -- 对应按键的使用 --
        controller.keySwitch()
        local buf = string.format("%d DOWN", keyCode)
        print(buf)
    end
 
    local function onKeyReleased(keyCode, event)

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