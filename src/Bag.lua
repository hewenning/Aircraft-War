bag = {}

function bag.bagView()
    local bagViewReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bagview.ccreator')
    local bagScene = bagViewReader:getSceneGraph()
    local bagNode = bagScene:getChildByName("bag")
    bagNode:removeFromParent(false)
    load.Canvas:addChild(bagNode)
    bag.propPurchase()
    bag.exitBagView()
end

function bag.exitBagView()
    local exitbag = load.Canvas:getChildByName("bag"):getChildByName("exitbag")
    exitbag:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Exitbag button pressed.")
            load.Canvas:getChildByName("bag"):removeFromParent()
            controller.setBulletAndAlienResume()
            menu.pressTag = 0 
        end
    end)
end

function bag.propPurchase()
    -- ȡ������ѡ��Ľ���Ľڵ� --
    bag.layout = load.Canvas:getChildByName("bag"):getChildByName("scrollview"):getChildByName("layout")
    bag.propFirstInfo()
end

-- �Ժ�ĵ��߿���дһ���� --
function bag.propFirstInfo()
    -- ��һ�����ߵĽڵ� --
    local propbombButton = bag.layout:getChildByName("propbomb")
    local propbombLabel = propbombButton:getChildByName("Background"):getChildByName("Label")
    propbombLabel:setString(prop.bombnum)
    -- ��������ʾ��Ϣ��ť --
    propbombButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("PropbombButton button pressed.")
            -- local str = "You have "..prop.bomnum.."bombs.Clear all,and get G3000."
            controller.infoDisplay("Clear all,and get G3000.") 
        end
    end)
end

return bag