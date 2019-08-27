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
    -- ȡ������ѡ��Ľ���Ľڵ� --
    local layout = load.Canvas:getChildByName("bag"):getChildByName("scrollview"):getChildByName("layout")
    -- ��һ�����ߵĽڵ� --
    local propbombButton = layout:getChildByName("propbomb")
    local propbombLabel = propbombButton:getChildByName("Background"):getChildByName("Label")
    propbombLabel:setString(prop.bombnum)
    -- ���������Ϸ�İ�ť --
    propbombButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Propbomb button pressed.")
            load.Canvas:getChildByName("bag"):removeFromParent()
        end
    end)

end

return bag