bag = {}

function bag.bagView()
    local bagViewReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bagview.ccreator')
    local bagScene = bagViewReader:getSceneGraph()
    local bagNode = bagScene:getChildByName("bag")
    bagNode:removeFromParent(false)
    load.Canvas:addChild(bagNode)
    bag.propPurchase()
end

function bag.propPurchase()
    -- 取到道具选择的界面的节点 --
    local layout = load.Canvas:getChildByName("bag"):getChildByName("scrollview"):getChildByName("layout")
    -- 第一个道具的节点 --
    local propbombButton = layout:getChildByName("propbomb")
    local propbombLabel = propbombButton:getChildByName("Background"):getChildByName("Label")
    propbombLabel:setString(prop.bombnum)
    -- 定义继续游戏的按钮 --
    propbombButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Propbomb button pressed.")
            load.Canvas:getChildByName("bag"):removeFromParent()
        end
    end)

end

return bag