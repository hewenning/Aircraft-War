require "move"


keyboard = {keyStatus = {},}


function keyboard.getKeyBoardStatus()
    -- �����µ�ͼ�� -- 
    local layer = cc.Layer:create()

    -- ��������¼� -- 
    local function onKeyPressed(keyCode, event)
        local buf = string.format("%d DOWN", keyCode)
        keyboard.keyStatus[keyCode] = 1
        print(buf)
        
        -- ���̿��� --
        controller.keySwitch()
    end
 
    local function onKeyReleased(keyCode, event)
        -- ������������ --
        -- local alienA = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
        -- alienA:getAlien(300, 200)

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