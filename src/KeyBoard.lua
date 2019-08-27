require "move"


keyboard = {keyStatus = {},}


function keyboard.getKeyBoardStatus()
    -- �����µ�ͼ�� -- 
    local layer = cc.Layer:create()

    -- ��������¼� -- 
    local function onKeyPressed(keyCode, event)
        keyboard.keyStatus[keyCode] = 1
        -- ��Ӧ������ʹ�� --
        controller.keySwitch()
        local buf = string.format("%d DOWN", keyCode)
        print(buf)
    end
 
    local function onKeyReleased(keyCode, event)

        keyboard.keyStatus[keyCode] = 0
        local buf = string.format("%d UP", keyCode)
        print(buf)
    end

    -- ע����̼����¼�--
    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)

    -- ����ͼ�� --
    return layer
end

return keyboard