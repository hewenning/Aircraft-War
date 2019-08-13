require "move"
keyboard = {}

function keyboard.getKeyBoardStatus()
    -- �����µ�ͼ�� -- 
    local layer = cc.Layer:create()

    -- ��������¼� -- 
    local function onKeyPressed(keyCode, event)
        local buf = string.format("%d DOWN", keyCode)
        if keyCode == 26 or keyCode == 124 then
            move.doleft()
        elseif keyCode == 27 or keyCode == 127 then
            move.doright()
        elseif keyCode == 28 or keyCode == 146 then
            move.doup()
        elseif keyCode == 29 or keyCode == 142 then
            move.dodown()
        else
            print(buf)
        end
    end
 
    local function onKeyReleased(keyCode, event)
        local buf = string.format("%d UP", keyCode)
        print(buf)
    end

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
 
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
    return layer

end

return keyboard